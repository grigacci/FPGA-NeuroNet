library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_mem.ALL;

entity mulmat is
    port (
        data_in_mulmat        : in std_logic_vector(data_size - 1 downto 0);    
        addr_in_mulmat               : in std_logic_vector(address_size - 1 downto 0);
        clk_mulmat            : in std_logic;
        valid_in_mulmat       : in std_logic;

        data_out_mulmat       : out std_logic_vector(data_size - 1 downto 0);
        done_o_mulmat         : out std_logic;
        ready_o_mulmat        : out std_logic;
        clk_o_mulmat          : out std_logic
    );
end mulmat;

architecture comportamental of mulmat is
begin
    process(data_in_mulmat,addr_in_mulmat,clk_mulmat)
    begin
    ready_o_mulmat <= '0';

        if valid_in_mulmat then

        if(to_integer(unsigned(addr_in_mulmat)) = input_size - 1) then
            done_o_mulmat <= '1';
            ready_o_mulmat <= '1';
        
        else
            data_out_mulmat <= std_logic_vector(((signed(data_in_mulmat))) * signed(weights(0,to_integer(unsigned(addr_in_mulmat)))));
            done_o_mulmat <= '0';
            ready_o_mulmat <= '1';
        end if;
    clk_o_mulmat <= clk_mulmat;

    end if;
    end process;
end comportamental;
