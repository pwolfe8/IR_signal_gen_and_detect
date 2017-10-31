--Engineer     : Philip Wolfe
--Date         : 10/21/2017
--Name of file : generate_code.vhd
--Description  : generates the example IR code from the rules
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_signal is
    generic (
        f_clk			    : positive := 7e6 -- freq of system clk
    );
    port (
        -- inputs --
        clk, rst, enable    : in  std_logic;
        three_bit_code      : in  std_logic_vector(2 downto 0);
        -- outputs --
        out_signal	        : out std_logic;
        done                : out std_logic
    );
end gen_signal;

architecture generate_code_arch of gen_signal is

    -- constant definitions (minus 1 for easiness because zero indexed)
    constant T_0 : positive := positive(real(f_clk) * real(1.12e-3))        - 1;
    constant T_1 : positive := positive(real(f_clk) * real(2.25e-3))        - 1;
    constant T_pulse : positive := positive(real(f_clk) * real(560.0e-6))   - 1;
    constant T_start : positive := positive(real(f_clk) * real(9.0e-3))     - 1;
    constant T_space : positive := positive(real(f_clk) * real(4.5e-3))     - 1;
    -- constant T_max   : positive := maximum( maximum(T_0,T_1), maximum(T_space,T_start) );
    -- T_start will always be T_max
    constant R : positive := 16;--positive( ceil(log2( real(T_start+1) )) ); --counter resolution
    
    -- type definitions
    type state_t is (IDLE, START_BURST, SPACE, SEND_MESSAGE, STOP_BURST);

    -- signal declarations
    signal state : state_t := IDLE;
    signal clk_counter : unsigned(R-1 downto 0);
    signal msg_bit_counter : unsigned(3 downto 0);

    -- construct 8-bit message (append 5 zeros to 3 bit message)
    signal message : std_logic_vector(7 downto 0);
    signal T_msg_bit : unsigned(R-1 downto 0) := to_unsigned(T_0,R); -- either T_0 or T_1 depSTOP_BIT on value at bit in message
    signal current_bit : std_logic;

    signal has_been_started : std_logic;
begin
-- consider changing 3 bit code to be based of switches later
    -- message <= "00000" & three_bit_code;
    -- big-ass state machine

    current_bit <= message(7);

    process ( rst, clk ) begin
        if ( rst='1' ) then
            has_been_started <= '0';
        elsif ( rising_edge(clk) and enable='1' ) then
            has_been_started <= '1';
        end if;
    end process;

    -- when else (like with select, but with any condition instead of checking one signal)
    done <= 
        '1' when (has_been_started='1' and state=IDLE) else
        '0';

    process (clk, rst, enable) begin
        if (rst='1') then
            clk_counter <= (others=>'0');
            out_signal <= '0';
            message <= "00000" & three_bit_code;
            state <= IDLE;
        elsif ( rising_edge(clk) ) then
            clk_counter <= clk_counter + 1; -- count clock rising edges

            -- state machine --
            case state is
                when IDLE =>
                    -- output value
                    out_signal <= '0';
                    -- next state logic
                    if ( enable = '1' ) then 
                        clk_counter <= (others=>'0');
                        state <= START_BURST;
                    end if;
                when START_BURST =>
                    -- output value
                    out_signal <= '1';
                    -- next state logic
                    if ( clk_counter = T_start ) then
                        clk_counter <= (others=>'0');
                        state <= SPACE;
                    end if;
                when SPACE =>
                    -- output value
                    out_signal <= '0';
                    -- next state logic
                    if ( clk_counter = T_space ) then 
                        clk_counter <= (others=>'0');
                        msg_bit_counter <= (others=>'0');
                        state <= SEND_MESSAGE;
                    end if;
                when SEND_MESSAGE =>
                    -- output value
                    if ( clk_counter <= T_pulse ) then
                        out_signal <= '1';
                    else
                        out_signal <= '0';
                    end if;
                    -- shift message & bit counter if finished with a bit
                    if ( clk_counter = T_msg_bit ) then
                        clk_counter <= (others=>'0');
                        message <= message(6 downto 0) & message(7); -- shift left
                        msg_bit_counter <= msg_bit_counter + 1;
                        if ( message(6)='1' ) then -- grab the upcoming period
                            T_msg_bit <= to_unsigned(T_1,R);
                        else
                            T_msg_bit <= to_unsigned(T_0,R);
                        end if;
                    end if;
                    -- next state logic
                    if ( msg_bit_counter(3) = '1' ) then -- when bit counter hits 8
                        clk_counter <= (others=>'0');
                        state <= STOP_BURST;
                    end if;
                when STOP_BURST =>
                    -- output value
                    out_signal <= '1';
                    -- next state logic
                    if ( clk_counter = T_pulse ) then
                        state <= IDLE;
                    end if;
                when others =>
                    state <= IDLE;
                end case;
        end if;
    end process;

end generate_code_arch;
