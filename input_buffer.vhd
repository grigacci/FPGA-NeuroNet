library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity input_buffer is
    port (
        clk             : in std_logic;
        input           : in std_logic_vector(weight_size - 1 downto 0);               --Pixel value input
        pixel_addr_in   : in std_logic_vector(address_size - 1 downto 0);                --Pixel address
        ready           : in std_logic_vector(number_of_neurons - 1 downto 0);         --Signal from the neuron after analyzing all the values

        clk_o           : out std_logic;                                               --Clk_o
        address         : out std_logic_vector(address_size - 1 downto 0);             
        output          : out std_logic_vector(weight_size - 1 downto 0);
        valid_out       : out std_logic
    );
end input_buffer;

architecture comportamental of input_buffer is
    type registerfile is array(input_size - 1 downto 0) of std_logic_vector((weight_size - 1) downto 0);
    variable index : integer := 0;
    signal banco : registerfile := (others => (others => '0'));
    signal valid : std_logic;
begin
    process (clk, ready, input,address, pixel_addr_in) is 
    begin
        while (valid = '1') and index /= (input_size - 1) loop                  --Reading loop
            valid_out <= valid;                                                 --Send valid
            output <= banco(index);                                             --Output the register data
            address <= std_logic_vector(to_unsigned(index,address'length));     --Output address

            if (ready = (others => '1')) then                                   --Jump for the next address if all neurons are ready
                index := index + 1;                                             --Update index
            end if;
        end loop;
        valid <= '0';                                                           --Update invalid
        
        while (valid = '0') and index /= (input_size - 1) loop                  --Writing loop
            valid_out <= valid;                                                 --Send invalid
            index := to_integer(unsigned(pixel_addr_in));                       --Update index
            banco(index) <= input;                                              --Write the data
        end loop;
        valid <= '1';                                                           --Update valid
            
    end process;
    valid_out <= valid;
    clk_o <= clk;
end comportamental;
