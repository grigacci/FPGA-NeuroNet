library ieee;
use ieee.std_logic_1164.all;
use work.CONFIG.ALL;

entity registrador is
    port (
        entrada_dados  : in std_logic_vector((weight_size - 1) downto 0);
        WE, clk, reset : in std_logic;
        saida_dados    : out std_logic_vector((weight_size - 1) downto 0)
    );
end registrador;

architecture comportamental of registrador is
begin
    process (clk) is
    begin
        if (rising_edge(clk)) then
            if (WE = '1') then
                saida_dados <= entrada_dados;
            end if;
            if (reset = '1') then
                saida_dados <= (others =>'0');
            end if;
        end if;
    end process;
end comportamental;