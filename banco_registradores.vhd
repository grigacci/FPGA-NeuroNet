library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity banco_registradores is
    port (
        entrada_ende    : in std_logic_vector((largura_ende - 1) downto 0); 
        write_data_reg  : in std_logic_vector((weight_size - 1) downto 0);     
        saida_dado      : out std_logic_vector((weight_size - 1) downto 0);
        clk, RegWEN     : in std_logic
    );
end banco_registradores;

architecture comportamental of banco_registradores is
    type registerfile is array(conexoes - 1 downto 0) of std_logic_vector((weight_size - 1) downto 0);
    signal banco : registerfile := (others => (others => '0'));
begin
    leitura : process (clk, entrada_ende) is 
    begin
        saida_dado <= banco(to_integer(unsigned(entrada_ende)));
    end process;

    escrita : process (clk) is
    begin
        if rising_edge(clk) and RegWEN = '1' then
                banco(to_integer(unsigned(entrada_ende))) <= write_data_reg((weight_size -1) downto 0);
        end if;
    end process;
end comportamental;