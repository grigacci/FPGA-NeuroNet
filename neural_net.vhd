library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CONFIG.ALL;
use work.mulmat_soft_mem.ALL;
use work.mulmat_relu_mem.ALL;
use work.bus_multiplexer_pkg.ALL;

entity neural_net is
    port (
        pixel : in std_logic_vector(data_size - 1 downto 0);
        addr  : in std_logic_vector(address_size - 1 downto 0);
        clk   : in std_logic;

        output : out std_logic_vector(3 downto 0);
        clk_o  : out std_logic
    );
end entity;

architecture comportamental of neural_net is

    component neuron_relu is 
        generic (
            neuron_number: integer
        );
    
        port (
            data    : in std_logic_vector(data_size - 1 downto 0);
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
            valid   : in std_logic;
    
            data_o  : out std_logic_vector(data_size - 1 downto 0);
            ready_o : out std_logic;
            clk_o   : out std_logic
        );
    end component;

    component neuron_soft is
        generic (
            neuron_number: integer
        );
    
        port (
            data    : in std_logic_vector(data_size - 1 downto 0);
            address : in std_logic_vector(address_size - 1 downto 0);  
            clk     : in std_logic;
            valid   : in std_logic;
    
            data_o  : out std_logic_vector(data_size - 1 downto 0);
            ready_o : out std_logic;
            clk_o   : out std_logic
        );
    end component;

    component output_softmax is 
        port (
            data_in_output_softmax        : in bus_array(output_classes - 1 downto 0)(data_size - 1 downto 0);    
            clk_output_softmax            : in std_logic;
    
            data_o_output_softmax          : out std_logic_vector(3 downto 0);
            clk_o_output_softmax           : out std_logic
        );
    end component;

begin

 -- continuar
end architecture;