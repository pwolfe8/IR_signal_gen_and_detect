--Engineer     : Philip Wolfe
--Date         : MM/DD/2017
--Name of file : tb_gen_signal.vhd
--Description  : Test bench for generate_code.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gen_signal is
end tb_gen_signal;

architecture tb_gen_signal_arch of tb_gen_signal is

    -- constant definitions
    constant f_clk : positive := 7e6;
    constant T: time := 142.857143 ns;

    -- period values for printout
    constant T_log_0 : positive := positive(real(f_clk) * real(1.12e-3))    - 1;
    constant T_log_1 : positive := positive(real(f_clk) * real(2.25e-3))    - 1;
    constant T_pulse : positive := positive(real(f_clk) * real(560.0e-6))   - 1;
    constant T_start : positive := positive(real(f_clk) * real(9.0e-3))     - 1;
    constant T_space : positive := positive(real(f_clk) * real(4.5e-3))     - 1;

    -- testbench signal declarations
    signal clk, rst : std_logic;
    signal enable, done : std_logic;
    signal three_bit_code : std_logic_vector(2 downto 0);
    signal out_signal : std_logic;

begin
    -- instantiate design under test
    DUT : entity work.gen_signal
        generic map (
            f_clk=>f_clk
        )
        port map (
            -- inputs
            clk=>clk, rst=>rst, enable=>enable, done=>done,
            three_bit_code=>three_bit_code,
            -- outputs --
            out_signal=>out_signal -- the generated output signal
        );
    
    
    -- setup clock
    process begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process;

    -- control reset 
    process begin
        -- report the constants
        report "constants - 1 (indexed at 0): ";
        report "f_clk: "    & positive'image(f_clk);
        report "T_log_0: "  & positive'image(T_log_0);
        report "T_log_1: "  & positive'image(T_log_1);
        report "T_pulse: "  & positive'image(T_pulse);
        report "T_start: "  & positive'image(T_start);
        report "T_space: "  & positive'image(T_space);

        three_bit_code <= "100";
        enable <= '0';
        rst <= '1';
        wait for T;
        rst <= '0';
        wait for 250 us;
        enable <= '1';
        wait for 250 us;
        enable <= '0';

        wait for 32 ms;
        -- wait; -- end test
        assert false report "Test completed" severity failure;
    end process;
    
end tb_gen_signal_arch;
