library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_relu_mem.ALL;
use ieee.fixed_pkg.all;
use work.bfloat_pkg.ALL;

entity mulmat_relu is
    generic (
        instance_number : integer
    );

    port (
        --ready_in_mulmat       : in std_logic_vector(output_classes - 1 downto 0);
        data_in_mulmat        : in bfloat16;    
        addr_in_mulmat        : in std_logic_vector(address_size - 1 downto 0);
        clk_in_mulmat         : in std_logic;

        data_out_mulmat       : out bfloat16;
        done_o_mulmat         : out std_logic
    );
end mulmat_relu;

architecture comportamental of mulmat_relu is

    signal done : std_logic;
    signal aux_data : bfloat16;

begin
    process(data_in_mulmat,addr_in_mulmat,clk_in_mulmat )
    begin
        if(rising_edge(clk_in_mulmat )) then

            if(to_integer(unsigned(addr_in_mulmat)) = input_size - 1) then
                done <= '1';
         
            else
                aux_data <= multiply(data_in_mulmat,relu_weights((to_integer(unsigned(addr_in_mulmat))),instance_number));
                done <= '0';
            end if;
            
        end if;
    end process;

    done_o_mulmat <= done;
    data_out_mulmat <= aux_data;

end comportamental;
