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

        data_o_bias_soft             : out bfloat16;
        clk_o_soft_bias_soft              : out std_logic
    );
end bias_soft;

architecture comportamental of bias_soft is
    signal bias_soft : float(0 downto -weight_size + 1) := soft_bias(instance_number);
    signal aux  : bfloat16;
begin
    process(data_in_bias_soft,clk_bias_soft)
    begin
        aux <= data_in_bias_soft + bias_soft;
        data_o_bias_soft <= aux;
        clk_o_soft_bias_soft <= clk_bias_soft;
    end process;
end comportamental;
