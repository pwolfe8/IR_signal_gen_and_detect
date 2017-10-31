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
        -- inputs --
        clk_oscillator  : in  std_logic;    -- input clock from 100MHz oscillator
        reset           : in  std_logic;    -- reset PLL

        -- outputs --
        clk_out         : out std_logic;    -- output clock (7MHz)
        locked          : out std_logic     -- high when phase-locked-loop has locked
     );
    end component;
    
    -- constant definitions
    constant f_clk : positive := 7e6; -- constraint also defined in pin_mappings.xdc (7MHz)
    
    -- local signal definitions
    signal clk : std_logic;
    signal reset, enable : std_logic;
    signal three_bit_code : std_logic_vector(2 downto 0);
    signal done : std_logic; 
    signal locked, out_signal : std_logic; -- output signals from PLL
    signal rst : std_logic; -- reset = not locked; input reset to gen_signal
                            -- basically don't start gen_signal unless PLL has locked(stabliized)

begin
    -- instantiate the Xilinx PLL IP
    pll_1 : PLL_100MHz_to_7MHz
    port map ( 
        clk_oscillator => osc_clk,  -- clock in (100MHz)
        reset => reset,             -- reset
        clk_out => clk,             -- clock out (7MHz)
        locked => locked            -- whether PLL has locked
    );

    -- connecting components to signals
    reset <= btnL;          -- left button resets PLL (and then system)
    rst <= not locked;      -- reset gen_signal if PLL not stable
    enable <= btnC;         -- center button starts sending message
    led15 <= done;          -- light up led15 when done sending
    three_bit_code <= sw;   -- tie switches to 3-bit code
    led <= sw;              -- also tie switches to leds above it
    JA_pin1 <= out_signal;  -- tie output signal to JA pin1

    -- instantiate the IR signal generator
    sig_gen1 : entity work.gen_signal
        generic map ( f_clk=>f_clk )
        port map (
            -- inputs --
            clk=>clk, 
            rst=>rst,
            enable=>enable,
            three_bit_code=>three_bit_code,
            -- outputs --
            out_signal=>out_signal,
            done=>done
        );

end top_level_gen_signal_arch;
