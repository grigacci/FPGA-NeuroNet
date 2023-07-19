library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.float_pkg.all;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.bfloat_pkg.ALL;

entity mulmat_soft is
    generic (
        instance_number : integer
    );

    port (
        data_in_mulmat_soft        : in bfloat16;    
        connection_in_mulmat_soft  : in std_logic_vector(5 downto 0);
        clk_mulmat_soft            : in std_logic;
        --valid_in_mulmat       : in std_logic;

        data_o_mulmat_soft       : out bfloat16;
        done_o_mulmat_soft         : out std_logic
    );
end mulmat_soft;

architecture comportamental of mulmat_soft is

    --signal one : std_logic_vector(output_classes - 1 downto 0) := (others => '1');
    signal done : std_logic := '0';
    signal aux_data : bfloat16 := to_bfloat16(0.0);
    signal weight : f4;

begin
    process(data_in_mulmat_soft,connection_in_mulmat_soft,clk_mulmat_soft)
    begin
        if(rising_edge(clk_mulmat_soft)) then

            if(to_integer(unsigned(connection_in_mulmat_soft)) = input_size - 1) then
                done <= '1';
            else
                weight <= soft_weights(to_integer(unsigned(connection_in_mulmat_soft)),instance_number);
                aux_data <= multiply(data_in_mulmat_soft,resize(weight,8,7));
                done <= '0';
            end if;

        end if;
    end process;

    data_o_mulmat_soft <= aux_data;
    done_o_mulmat_soft <= done;

end comportamental;
