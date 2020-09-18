----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2019 13:34:14
-- Design Name: 
-- Module Name: counter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_tb is
--  Port ( );
end counter_tb;

architecture Behavioral of counter_tb is

component counter_100 is
Port ( clk: in std_logic; 
       start: in std_logic;
       ready: out std_logic
           );
end component;

signal clk : std_logic := '0';
signal start, ready : std_logic ;
signal clk_period: time:= 10ns;

begin
uut : counter_100 Port Map(
clk => clk,
start => start,
ready => ready );

clk_process:process
begin

clk<='0';
wait for clk_period/2;
clk<='1';
wait for clk_period/2;
end process;

simulation : process
begin
start <= '1';
wait for 10ns;
wait;
end process;

end Behavioral;
