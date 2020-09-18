library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port ( decoder_in : in STD_LOGIC_VECTOR (1 downto 0);
           enable : in STD_LOGIC;
           decoder_out : out STD_LOGIC_VECTOR (3 downto 0));
end decoder;


architecture Behavioral of decoder is

signal previous :  std_logic_vector(3 downto 0) := "0000";

begin

decoder_out <="0000" when enable='0' else
              "0001" when enable='1' and decoder_in="00" else
              "0010" when enable='1' and decoder_in="01" else
              "0100" when enable='1' and decoder_in="10" else
              "1000" when enable='1' and decoder_in="11"; 
       
            
         
end Behavioral;
