library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity bias_soft is
    generic (
        instance_number : integer
    );

    port (
        data_in_bias_soft            : in bfloat16;    
        clk_bias_soft                : in std_logic;

        data_o_bias_soft             : out bfloat16
    );
end bias_soft;

architecture comportamental of bias_soft is
    signal bias_soft : f4 := soft_bias(instance_number);
begin
    process(data_in_bias_soft,clk_bias_soft)
    begin
        if(rising_edge(clk_bias_soft)) then
            data_o_bias_soft <= add(data_in_bias_soft,resize(bias_soft,8,7));   
        end if;
    end process;
end comportamental;
