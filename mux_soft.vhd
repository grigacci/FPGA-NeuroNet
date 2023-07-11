library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.bfloat_pkg.ALL;

entity mux_soft is
    generic (
        instance_number : integer
    );

    port (
        data_in_mux_soft : in bus_bfloat16(number_of_neurons - 1 downto 0);
        addr_in_mux_soft : in std_logic_vector(address_size - 1 downto 0);
        clk_mux_soft     : in std_logic;

        data_o_mux_soft : out bfloat16;
        connection_o_mux_soft : out std_logic_vector(5 downto 0)
    );

end mux_soft;

architecture comportamental of mux_soft is

signal last_addr : std_logic_vector(address_size - 1 downto 0);
signal cont      : integer := 0;

begin
    process (clk_mux_soft,addr_in_mux_soft,data_in_mux_soft)
    begin
        if(rising_edge(clk_mux_soft)) then
            if (addr_in_mux_soft = last_addr) then 
                if (cont <= number_of_neurons) then 
                    data_o_mux_soft <= data_in_mux_soft(cont);
                    cont <= cont + 1;
                    connection_o_mux_soft <= std_logic_vector(to_unsigned(cont,connection_o_mux_soft'length));
                end if;
            else 
                last_addr <= addr_in_mux_soft;
                cont <= 1;
                data_o_mux_soft <= data_in_mux_soft(0);
                connection_o_mux_soft <= std_logic_vector(to_unsigned(cont - 1,connection_o_mux_soft'length));
            end if;
        end if;
    end process;

    

end architecture;