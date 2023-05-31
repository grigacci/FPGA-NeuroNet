library ieee;
use ieee.std_logic_1164.all;
use work.CONFIG.ALL;

entity mux161 is
    generic (
        largura_dado : natural := 32
    );
    port (
        dado_ent_0, dado_ent_1, dado_ent_2, dado_ent_3, 
        dado_ent_4, dado_ent_5,dado_ent_6, dado_ent_7, 
        dado_ent_8, dado_ent_9, dado_ent_10, dado_ent_11,
        dado_ent_12,dado_ent_13,dado_ent_14,dado_ent_15 
        : in std_logic_vector((weight_size - 1) downto 0);
        sele_ent                                       : in std_logic_vector(3 downto 0);
        dado_sai                                       : out std_logic_vector((weight_size - 1) downto 0)
    );
end mux161;

architecture dataflow of mux161 is
begin
    with sele_ent select
        dado_sai <= dado_ent_0 when "0000",  
        dado_ent_1 when "0001", 
        dado_ent_2 when "0010", 
        dado_ent_3 when "0011",
        dado_ent_4 when "0100",
        dado_ent_5 when "0101",
        dado_ent_6 when "0110",
        dado_ent_7 when "0111",
        dado_ent_8 when "1000",
        dado_ent_9 when "1001",
        dado_ent_10 when "1010",
        dado_ent_11 when "1011",
        dado_ent_12 when "1100",
        dado_ent_13 when "1101",
        dado_ent_14 when "1110",
        dado_ent_15 when "1111";

end dataflow;