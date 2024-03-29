library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.mulmat_relu_mem.ALL;
use work.bus_multiplexer_pkg.ALL;
use work.bfloat_pkg.ALL;
use ieee.float_pkg.all;

entity neural_net is
    port (
        pixel : in bfloat16;
        addr  : in std_logic_vector(address_size - 1 downto 0);
        clk   : in std_logic;

        output_nn : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behave of neural_net is

    component neuron_relu is 
        generic (
            neuron_number : integer
        );
    
        port (
            data    : in bfloat16;
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
            --ready_in: in std_logic_vector(output_classes - 1 downto 0);
 
            data_o  : out bfloat16
        );
    end component;

    component neuron_soft is
        generic (
            neuron_number: integer
        );
    
        port (
            data    : in bus_bfloat16(number_of_neurons - 1 downto 0);
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
    
            data_o  : out bfloat16
        );
    end component;

    component output_softmax is 
        port (
            data_in_output_softmax        : in bus_bfloat16(output_classes - 1 downto 0);    
            clk_output_softmax            : in std_logic;
    
            data_o_output_softmax          : out std_logic_vector(3 downto 0)
        );
    end component;

    type soft_output is array (output_classes - 1 downto 0) of bfloat16;

    signal aux_soft_output : bus_bfloat16(output_classes - 1 downto 0);
    signal aux_relu_output : bus_bfloat16(number_of_neurons - 1 downto 0);
    signal aux_ready_relu  : std_logic_vector(number_of_neurons - 1 downto 0);
    signal aux_ready_soft  : std_logic_vector(output_classes - 1 downto 0);

begin

    gen_layer1 : for i in 0 to number_of_neurons - 1 generate
        instance_neuron_relu : component neuron_relu 
            generic map (
                neuron_number => i
            )
            port map (
                data => pixel,
                address => addr,
                clk => clk,

                data_o => aux_relu_output(i)
            );
        end generate;


    gen_layer2 : for cont in 0 to output_classes - 1 generate
        instance_neuron_soft : component neuron_soft
            generic map (
                neuron_number => cont
            )
            port map (
                data => aux_relu_output,
                address => addr,
                clk => clk,
                         
                data_o => aux_soft_output(cont)
            );
            end generate;
    

    instance_output : component output_softmax
            port map (
                data_in_output_softmax(0) => aux_soft_output(0),
                data_in_output_softmax(1) => aux_soft_output(1),
                data_in_output_softmax(2) => aux_soft_output(2),
                data_in_output_softmax(3) => aux_soft_output(3),
                data_in_output_softmax(4) => aux_soft_output(4),
                data_in_output_softmax(5) => aux_soft_output(5),
                data_in_output_softmax(6) => aux_soft_output(6),
                data_in_output_softmax(7) => aux_soft_output(7),
                data_in_output_softmax(8) => aux_soft_output(8),
                data_in_output_softmax(9) => aux_soft_output(9),

                clk_output_softmax => clk,
            
                data_o_output_softmax => output_nn
            );            
           
    
 -- continuar
end architecture;