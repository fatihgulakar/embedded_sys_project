----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2019 16:28:44
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( clk : in STD_LOGIC;
           start: in STD_LOGIC;
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           out_port : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

component kcpsm6 is
  generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"FFF";
           scratch_pad_memory_size : integer := 64);
  port (                   address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
  end component kcpsm6;

component BRAM0 is
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    clk : in std_logic);
end component BRAM0;

component counter is
Port ( clk: in std_logic; 
       start: in std_logic;
       count_up_to: in std_logic_vector(15 downto 0);
       ready: out std_logic
           );
end component;

component priorityy_encoder is
    Port ( encoder_in : in STD_LOGIC_VECTOR (3 downto 0);
           encoder_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component decoder is
    Port ( decoder_in : in STD_LOGIC_VECTOR (1 downto 0);
           enable : in STD_LOGIC;
           decoder_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal address :  std_logic_vector(11 downto 0);
signal in_port :  std_logic_vector(7 downto 0);
signal instruction :  std_logic_vector(17 downto 0);
signal bram_enable :  std_logic;
signal write_strobe :  std_logic;
signal k_write_strobe :  std_logic;
signal read_strobe :  std_logic;
signal interrupt_ack :  std_logic;
signal ready_or :  std_logic;
signal ready1, ready2, ready3, ready4 :  std_logic;
signal start1, start2, start3, start4 :  std_logic;
signal encoder_in:  std_logic_vector(3 downto 0);
signal encoder_out:  std_logic_vector(2 downto 0);
signal decoder_out:  std_logic_vector(3 downto 0);

begin

picoblaze: kcpsm6 
generic map(
                          hwbuild => X"00",
                 interrupt_vector => X"FFF",
          scratch_pad_memory_size => 64       )
port map(
                           address => address,
                       instruction => instruction,
                       bram_enable => bram_enable,
                           in_port => in_port,
                          out_port => out_port,
                           port_id => port_id,
                      write_strobe => write_strobe,
                    k_write_strobe => k_write_strobe,
                       read_strobe => read_strobe,
                         interrupt => ready_or,
                     interrupt_ack => interrupt_ack,
                             sleep => '0',
                             reset => '0',
                               clk => clk
);

inst_mem: BRAM0
port map(
                address => address,
            instruction => instruction,
                 enable => bram_enable,
                    clk => clk
                     );
                     
c100: counter
port map(
                clk => clk,
              start => start1,
              count_up_to => X"0064",
              ready => ready1
                     );
                     
c200: counter
port map(
                clk => clk,
              start => start2,
              count_up_to => X"00C8",
              ready => ready2
                     );                                           

c300: counter
port map(
                clk => clk,
              start => start3,
              count_up_to => X"012C",
              ready => ready3
                     );  

c400: counter
port map(
                clk => clk,
              start => start4,
              count_up_to => X"0190",
              ready => ready4
                     );  
                     
p_encoder: priorityy_encoder
port map(
              encoder_in => encoder_in,
              encoder_out => encoder_out
                     );  
 
 encoder_in(0) <= ready1;
 encoder_in(1) <= ready2;
 encoder_in(2) <= ready3;
 encoder_in(3) <= ready4;
 
deco: decoder
port map(
              decoder_in => encoder_out(1 downto 0),
              enable => interrupt_ack,
              decoder_out => decoder_out
                     );  
 
 start1 <= decoder_out(0);
 start2 <= decoder_out(1);
 start3 <= decoder_out(2);
 start4 <= decoder_out(3);
 
 in_port(2 downto 0) <= encoder_out;
 in_port(7 downto 3) <= "00000";
 
 ready_or <= ready1 or ready2 or ready3 or ready4 or start;
 
                     
end Behavioral;
