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

            output_nn : out std_logic_vector(3 downto 0)
        );
        end component; 

        signal clock : std_logic;
        signal pixel_in : bfloat16;
        signal addr_in : std_logic_vector(address_size - 1 downto 0);
        signal output_o : std_logic_vector(3 downto 0);

        constant PERIOD    : time := 20 ns;
        --constant DUTY_CYCLE : real := 0.5;
        --constant OFFSET     : time := 5 ns;

        signal aux_saida : std_logic_vector(3 downto 0);
        
        signal ones : std_logic_vector(number_of_neurons - 1 downto 0) := (others => '1');
begin

    instance : neural_net 
    port map (
        pixel => pixel_in,
        addr => addr_in,
        clk => clock,
        output_nn => output_o
    );

    gen_clock: process
    begin
        clock <= not(clock);
        wait for PERIOD/2;
	end process;

    input : process (clock)
    begin
        if rising_edge(clock) then
        for i in 0 to 27 loop
            for x in 0 to 27 loop
                    pixel_in <= input_image(i,x);
                    addr_in <= std_logic_vector(to_unsigned(((i * 27) + x),addr_in'length));
            end loop;
        end loop;
        end if;
    end process;
    
    aux_saida <= output_o;
    
end architecture;