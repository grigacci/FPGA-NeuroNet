library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CONFIG.ALL;

entity mulmat is
    port (
        data_in_mulmat        : in std_logic_vector(data_size - 1 downto 0);    
        addr_in               : in std_logic_vector(largura_ende - 1 downto 0);
        clk_mulmat            : in std_logic;
        valid_in_mulmat       : in std_logic;

        data_out_mulmat       : out std_logic_vector(data_size - 1 downto 0);
        done_o_mulmat         : out std_logic;
        ready_o_mulmat        : out std_logic;
        clk_o_mulmat          : out std_logic
    );
end mulmat;

architecture comportamental of mulmat is
    type registerfile is array(input_size - 1 downto 0) of std_logic_vector((weight_size - 1) downto 0);
    signal banco : registerfile := (others => (others => '0'));
begin
    process(data_in_mulmat,addr_in,clk_mulmat)
    begin
    ready_o_mulmat <= '0';

        if valid_in_mulmat then

        if(to_integer(unsigned(addr_in)) = input_size - 1) then
            done_o_mulmat <= '1';
            ready_o_mulmat <= '1';
        
        else
            data_out_mulmat <= std_logic_vector(((unsigned(data_in_mulmat))) * unsigned(banco(to_integer(unsigned(addr_in)))));
            done_o_mulmat <= '0';
            ready_o_mulmat <= '1';
        end if;
    clk_o_mulmat <= clk_mulmat;

    end if;
    end process;
end comportamental;
