--Engineer     : Philip Wolfe
--Date         : 10/26/2017
--Name of file : top_level_gen_signal.vhd
--Description  : top level entity to instantiate
--               signal generator and connect to pins. 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_gen_signal is
    port (
        -- inputs --
        osc_clk : in  std_logic;                    -- clock freq from oscillator (100MHz)
        btnL    : in  std_logic;                    -- reset mapped to active high left button
        btnC    : in  std_logic;                    -- center button for enable to start sending
        sw      : in  std_logic_vector(2 downto 0); -- switches[2..0] to control 3-bit code
        
        -- outputs --
        led	    : out std_logic_vector(2 downto 0); -- leds[2..0] match sw[2..0]
        led15   : out std_logic;                    -- lights up when done sending message
        JA_pin1 : out std_logic                     -- the actual signal goes out here
    );
end top_level_gen_signal;

architecture top_level_gen_signal_arch of top_level_gen_signal is
    -- Xilinx IP: PLL component declaration
    component PLL_100MHz_to_7MHz
    port (
        -- Clock in ports
        clk_oscillator  : in  std_logic;
        -- Clock out ports
        clk_out         : out std_logic;
        -- Status and control signals
        reset           : in  std_logic
     );
    end component;
    
    -- constant definitions
    constant f_clk : positive := 7e6; --defined in pin_mappings.xdc (7MHz, 200ns period)
    
    -- local signal definitions
    signal clk : std_logic;
    signal reset, enable : std_logic;
    signal three_bit_code : std_logic_vector(2 downto 0);
    signal out_signal : std_logic;
    

begin
    pll_1 : PLL_100MHz_to_7MHz
    port map ( 
        clk_oscillator => osc_clk,  -- Clock in ports
        reset => reset,             -- Status and control signals
        clk_out => clk              -- Clock out ports  
    );
    
    reset <= btnL; -- left button resets
    enable <= btnC; -- center button starts sending message
    led <= sw; -- map switch code to leds above it
    JA_pin1 <= out_signal; -- map output signal to JA pin1

    process ( clk, reset ) begin -- read & store switches after reset
        if ( rising_edge(clk) and reset='1' ) then
            three_bit_code <= sw;
        end if;
    end process;

    sig_gen1 : entity work.gen_signal
        generic map ( f_clk=>f_clk )
        port map (
            -- inputs --
            clk=>clk, 
            rst=>reset,
            enable=>enable,
            three_bit_code=>three_bit_code,
            -- outputs --
            out_signal=>out_signal,
            done=>led15
        );
    
end top_level_gen_signal_arch;
