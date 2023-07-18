library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_relu_mem.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity bias_relu is
    generic (
        instance_number : integer
    );

    port (
        data_in_bias_relu            : in bfloat16;    
        clk_bias_relu                : in std_logic;

        data_o_bias_relu             : out bfloat16
    );
end bias_relu;

architecture rtl of bias_relu is
    signal bias_relu : f4 := relu_bias(instance_number);
    signal aux_sum : float(20 downto -19);
begin
    sum_proc : process(data_in_bias_relu,clk_bias_relu)
    begin
        if(rising_edge(clk_bias_relu)) then
            aux_sum <= add(data_in_bias_relu , resize(bias_relu, data_o_bias_relu'length));
        end if;
    end process;
    data_o_bias_relu <= aux_sum(8 downto -7);
end rtl;
