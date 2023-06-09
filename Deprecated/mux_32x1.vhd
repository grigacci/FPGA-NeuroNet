library ieee;
use ieee.std_logic_1164.all;
use work.CONFIG.ALL;

entity mux_32_1 is
    port (
        dado_ent_0, dado_ent_1, dado_ent_2, dado_ent_3, 
        dado_ent_4, dado_ent_5,dado_ent_6, dado_ent_7, 
        dado_ent_8, dado_ent_9, dado_ent_10, dado_ent_11,
        dado_ent_12,dado_ent_13,dado_ent_14,dado_ent_15,
        dado_ent_16, dado_ent_17, dado_ent_18, dado_ent_19, 
        dado_ent_20, dado_ent_21,dado_ent_22, dado_ent_23, 
        dado_ent_24, dado_ent_25, dado_ent_26, dado_ent_27,
        dado_ent_28,dado_ent_29,dado_ent_30,dado_ent_31  
        : in std_logic_vector((data_size - 1) downto 0);
        sele_ent                                       : in std_logic_vector(4 downto 0);
        dado_sai                                       : out std_logic_vector((data_size - 1) downto 0)
    );
end mux_32_1;

architecture dataflow of mux_32_1 is
begin
    with sele_ent select
        dado_sai <= dado_ent_0 when "00000",  
        dado_ent_1 when "00001", 
        dado_ent_2 when "00010", 
        dado_ent_3 when "00011",
        dado_ent_4 when "00100",
        dado_ent_5 when "00101",
        dado_ent_6 when "00110",
        dado_ent_7 when "00111",
        dado_ent_8 when "01000",
        dado_ent_9 when "01001",
        dado_ent_10 when "01010",
        dado_ent_11 when "01011",
        dado_ent_12 when "01100",
        dado_ent_13 when "01101",
        dado_ent_14 when "01110",
        dado_ent_15 when "01111",
        dado_ent_16 when "10000",  
        dado_ent_17 when "10001", 
        dado_ent_18 when "10010", 
        dado_ent_19 when "10011",
        dado_ent_20 when "10100",
        dado_ent_21 when "10101",
        dado_ent_22 when "10110",
        dado_ent_23 when "10111",
        dado_ent_24 when "11000",
        dado_ent_25 when "11001",
        dado_ent_26 when "11010",
        dado_ent_27 when "11011",
        dado_ent_28 when "11100",
        dado_ent_29 when "11101",
        dado_ent_30 when "11110",
        dado_ent_31 when "11111";

end dataflow;