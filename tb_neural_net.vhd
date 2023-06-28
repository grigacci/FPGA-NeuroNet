library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
use work.input_data.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity tb_neural_net is
end tb_neural_net;

architecture rtl of tb_neural_net is

    component neural_net 
        port (
            pixel : in bfloat16;
            addr  : in std_logic_vector(address_size - 1 downto 0);
            clk   : in std_logic;
            --ready_in : out std_logic_vector(number_of_neurons - 1 downto 0);
            --valid_in : in std_logic;
            ready_input_o : out std_logic_vector(number_of_neurons - 1 downto 0);
            output : out std_logic_vector(3 downto 0);
            clk_o  : out std_logic
        );
        end component; 

        signal clock : std_logic;
        signal pixel_in : bfloat16;
        signal addr_in : std_logic_vector(address_size - 1 downto 0);
        signal output_o : std_logic_vector(3 downto 0);
        signal ready_in_i : std_logic_vector(number_of_neurons - 1 downto 0);

        constant PERIOD    : time := 20 ns;
        constant DUTY_CYCLE : real := 0.5;
        constant OFFSET     : time := 5 ns;
        
        signal ones : std_logic_vector(number_of_neurons - 1 downto 0) := (others => '1');

begin

    instance : neural_net 
    port map (
        pixel => pixel_in,
        addr => addr_in,
        clk => clock,
        output => output_o,
        ready_input_o => ready_in_i
    );

    gen_clock: process
    begin
		wait for OFFSET;
		CLOCK_LOOP :
        for i in 0 to 65535 loop
			clock <= '1';
			wait for (PERIOD - (PERIOD * DUTY_CYCLE));
			clock <= '0';
			wait for (PERIOD * DUTY_CYCLE);
		end loop CLOCK_LOOP;
	end process;

    input : process 
    begin
        for i in 27 downto 0 loop
            for x in 27 downto 0 loop
                while ready_in_i /= ones loop
                    pixel_in <= input_image(i,x);
                end loop;
            end loop;
        end loop;
    end process;

end architecture;