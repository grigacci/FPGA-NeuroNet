library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;


entity input_buffer is
    port (
        clk             : in std_logic;
        input           : in std_logic_vector(weight_size - 1 downto 0);    --Pixel value input
        pixel_addr_in   : in std_logic_vector(input_size - 1 downto 0);                --Pixel address
        ready           : in std_logic_vector(number_of_neurons - 1 downto 0);                                     --Signal from the neuron after analyzing all the values

        address         : out std_logic_vector(largura_ende - 1 downto 0);
        output          : out std_logic_vector(weight_size - 1 downto 0);
        valid_out       : out std_logic
    );
end input_buffer;

architecture comportamental of input_buffer is
    type registerfile is array(input_size - 1 downto 0) of std_logic_vector((weight_size - 1) downto 0);
    signal banco : registerfile := (others => (others => '0'));
    signal valid : std_logic;
begin
    process (clk, pixel_addr_in, ready, input,address) is 
    begin
        if (valid = '1' and ready /= (others => '1') ) then     --Leitura
            for i in 0 to (input_size - 1) loop 
                output <= banco(i);
                address <= std_logic_vector(to_unsigned(i,address'length));
            end loop;
            valid <= '0';

        elsif rising_edge(clk) and ready = ((others => '1')) and (valid = '0') then --Escrita
            for i in 0 to (input_size - 1) loop 
                banco(to_integer(unsigned(pixel_addr_in))) <= input((weight_size - 1) downto 0);
            end loop;
            valid <= '1';
            
        end if;
    end process;
    valid_out <= valid;
end comportamental;
