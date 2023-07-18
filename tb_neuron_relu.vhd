library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;
--use work.input_data.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity tb_neuron_relu is
end tb_neuron_relu;

architecture rtl of tb_neuron_relu is
    component neuron_relu 
        generic (
            neuron_number : integer
        );

        port (
            data    : in bfloat16;
            address : in std_logic_vector(address_size - 1 downto 0);
            clk     : in std_logic;

            data_o  : out bfloat16
        );
        end component; 

        signal clock : std_logic;
        signal aux_data_in : bfloat16;
        signal aux_addr_in : std_logic_vector(address_size - 1 downto 0);
        signal aux_data_o : bfloat16;

        constant PERIOD    : time := 10 ns;
        constant inst : integer := 0;
        
        signal i : integer ;

begin

    instance : neuron_relu 
    generic map (
        neuron_number => inst
    );

    port map (
        data => aux_data_in,
        address => aux_addr_in,
        clk => clock,
        data_o => aux_data_o
    );

    gen_clock: process
    begin
        clock <= not(clock);
        wait for PERIOD/2;
	end process;

    input : process (clock)
    begin
        if rising_edge(clock) then
            aux_data_in <= to_bfloat16(i);
            aux_addr_in <= std_logic_vector(to_unsigned(i,aux_addr_in'length));
            i <= i + 1;
        end if;
    end process;
end architecture;