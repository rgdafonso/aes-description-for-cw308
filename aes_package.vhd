--*************************************************************************
-- Project    : AES128                                                    *
--                                                                        *
-- Block Name : aes_package.vhd                                           *
--                                                                        *
-- Author     : Hemanth Satyanarayana                                     *
--                                                                        *
-- Email      : hemanth@opencores.org                                     *
--                                                                        *
-- Description: Package containing state array type declaration,          *
--              S-box functions and Mix columns routine for               *
--              rtl modules.                                              *
--                                                                        *
-- Revision History                                                       *
-- |-----------|-------------|---------|---------------------------------|*
-- |   Name    |    Date     | Version |          Revision details       |*
-- |-----------|-------------|---------|---------------------------------|*
-- | Hemanth   | 15-Dec-2004 | 1.1.1.1 |            Uploaded             |*
-- |-----------|-------------|---------|---------------------------------|*
--                                                                        *
--  Refer FIPS-197 document for details                                   *
--*************************************************************************
--                                                                        *
-- Copyright (C) 2004 Author                                              *
--                                                                        *
-- This source file may be used and distributed without                   *
-- restriction provided that this copyright statement is not              *
-- removed from the file and that any derivative work contains            *
-- the original copyright notice and the associated disclaimer.           *
--                                                                        *
-- This source file is free software; you can redistribute it             *
-- and/or modify it under the terms of the GNU Lesser General             *
-- Public License as published by the Free Software Foundation;           *
-- either version 2.1 of the License, or (at your option) any             *
-- later version.                                                         *
--                                                                        *
-- This source is distributed in the hope that it will be                 *
-- useful, but WITHOUT ANY WARRANTY; without even the implied             *
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR                *
-- PURPOSE.  See the GNU Lesser General Public License for more           *
-- details.                                                               *
--                                                                        *
-- You should have received a copy of the GNU Lesser General              *
-- Public License along with this source; if not, download it             *
-- from http://www.opencores.org/lgpl.shtml                               *
--                                                                        *
--*************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package aes_package is

-- This data type is declared to make all operations on a vector of 4 bytes ecach
-- refer fips-197 doc, sec 3.5
type state_array_type is array (0 to 3) of std_logic_vector(7 downto 0);

-- S-Box look up function
function sbox_val(address: std_logic_vector(7 downto 0)) return std_logic_vector;
-- column generation fucntion for Mix columns routine
function col_transform(p: state_array_type) return std_logic_vector;
-- Mix Columns function
function mix_cols_routine
     (
       a_r0 : state_array_type;
       a_r1 : state_array_type;
       a_r2 : state_array_type;
       a_r3 : state_array_type
     )
return std_logic_vector;

end aes_package; 

package body aes_package is

function sbox_val(address: std_logic_vector(7 downto 0)) return std_logic_vector is
variable data: bit_vector(7 downto 0);
variable data_stdlogic: std_logic_vector(7 downto 0);
begin
case address is

  when "00000000" => data := X"63";
  when "00000001" => data := X"7C";
  when "00000010" => data := X"77";
  when "00000011" => data := X"7B";
  when "00000100" => data := X"F2";
  when "00000101" => data := X"6B";
  when "00000110" => data := X"6F";
  when "00000111" => data := X"C5";
  when "00001000" => data := X"30";
  when "00001001" => data := X"01";
  when "00001010" => data := X"67";
  when "00001011" => data := X"2B";
  when "00001100" => data := X"FE";
  when "00001101" => data := X"D7";
  when "00001110" => data := X"AB";
  when "00001111" => data := X"76";
  when "00010000" => data := X"CA";
  when "00010001" => data := X"82";
  when "00010010" => data := X"C9";
  when "00010011" => data := X"7D";
  when "00010100" => data := X"FA";
  when "00010101" => data := X"59";
  when "00010110" => data := X"47";
  when "00010111" => data := X"F0";
  when "00011000" => data := X"AD";
  when "00011001" => data := X"D4";
  when "00011010" => data := X"A2";
  when "00011011" => data := X"AF";
  when "00011100" => data := X"9C";
  when "00011101" => data := X"A4";
  when "00011110" => data := X"72";
  when "00011111" => data := X"C0";
  when "00100000" => data := X"B7";
  when "00100001" => data := X"FD";
  when "00100010" => data := X"93";
  when "00100011" => data := X"26";
  when "00100100" => data := X"36";
  when "00100101" => data := X"3F";
  when "00100110" => data := X"F7";
  when "00100111" => data := X"CC";
  when "00101000" => data := X"34";
  when "00101001" => data := X"A5";
  when "00101010" => data := X"E5";
  when "00101011" => data := X"F1";
  when "00101100" => data := X"71";
  when "00101101" => data := X"D8";
  when "00101110" => data := X"31";
  when "00101111" => data := X"15";
  when "00110000" => data := X"04";
  when "00110001" => data := X"C7";
  when "00110010" => data := X"23";
  when "00110011" => data := X"C3";
  when "00110100" => data := X"18";
  when "00110101" => data := X"96";
  when "00110110" => data := X"05";
  when "00110111" => data := X"9A";
  when "00111000" => data := X"07";
  when "00111001" => data := X"12";
  when "00111010" => data := X"80";
  when "00111011" => data := X"E2";
  when "00111100" => data := X"EB";
  when "00111101" => data := X"27";
  when "00111110" => data := X"B2";
  when "00111111" => data := X"75";
  when "01000000" => data := X"09";
  when "01000001" => data := X"83";
  when "01000010" => data := X"2C";
  when "01000011" => data := X"1A";
  when "01000100" => data := X"1B";
  when "01000101" => data := X"6E";
  when "01000110" => data := X"5A";
  when "01000111" => data := X"A0";
  when "01001000" => data := X"52";
  when "01001001" => data := X"3B";
  when "01001010" => data := X"D6";
  when "01001011" => data := X"B3";
  when "01001100" => data := X"29";
  when "01001101" => data := X"E3";
  when "01001110" => data := X"2F";
  when "01001111" => data := X"84";
  when "01010000" => data := X"53";
  when "01010001" => data := X"D1";
  when "01010010" => data := X"00";
  when "01010011" => data := X"ED";
  when "01010100" => data := X"20";
  when "01010101" => data := X"FC";
  when "01010110" => data := X"B1";
  when "01010111" => data := X"5B";
  when "01011000" => data := X"6A";
  when "01011001" => data := X"CB";
  when "01011010" => data := X"BE";
  when "01011011" => data := X"39";
  when "01011100" => data := X"4A";
  when "01011101" => data := X"4C";
  when "01011110" => data := X"58";
  when "01011111" => data := X"CF";
  when "01100000" => data := X"D0";
  when "01100001" => data := X"EF";
  when "01100010" => data := X"AA";
  when "01100011" => data := X"FB";
  when "01100100" => data := X"43";
  when "01100101" => data := X"4D";
  when "01100110" => data := X"33";
  when "01100111" => data := X"85";
  when "01101000" => data := X"45";
  when "01101001" => data := X"F9";
  when "01101010" => data := X"02";
  when "01101011" => data := X"7F";
  when "01101100" => data := X"50";
  when "01101101" => data := X"3C";
  when "01101110" => data := X"9F";
  when "01101111" => data := X"A8";
  when "01110000" => data := X"51";
  when "01110001" => data := X"A3";
  when "01110010" => data := X"40";
  when "01110011" => data := X"8F";
  when "01110100" => data := X"92";
  when "01110101" => data := X"9D";
  when "01110110" => data := X"38";
  when "01110111" => data := X"F5";
  when "01111000" => data := X"BC";
  when "01111001" => data := X"B6";
  when "01111010" => data := X"DA";
  when "01111011" => data := X"21";
  when "01111100" => data := X"10";
  when "01111101" => data := X"FF";
  when "01111110" => data := X"F3";
  when "01111111" => data := X"D2";
  when "10000000" => data := X"CD";
  when "10000001" => data := X"0C";
  when "10000010" => data := X"13";
  when "10000011" => data := X"EC";
  when "10000100" => data := X"5F";
  when "10000101" => data := X"97";
  when "10000110" => data := X"44";
  when "10000111" => data := X"17";
  when "10001000" => data := X"C4";
  when "10001001" => data := X"A7";
  when "10001010" => data := X"7E";
  when "10001011" => data := X"3D";
  when "10001100" => data := X"64";
  when "10001101" => data := X"5D";
  when "10001110" => data := X"19";
  when "10001111" => data := X"73";
  when "10010000" => data := X"60";
  when "10010001" => data := X"81";
  when "10010010" => data := X"4F";
  when "10010011" => data := X"DC";
  when "10010100" => data := X"22";
  when "10010101" => data := X"2A";
  when "10010110" => data := X"90";
  when "10010111" => data := X"88";
  when "10011000" => data := X"46";
  when "10011001" => data := X"EE";
  when "10011010" => data := X"B8";
  when "10011011" => data := X"14";
  when "10011100" => data := X"DE";
  when "10011101" => data := X"5E";
  when "10011110" => data := X"0B";
  when "10011111" => data := X"DB";
  when "10100000" => data := X"E0";
  when "10100001" => data := X"32";
  when "10100010" => data := X"3A";
  when "10100011" => data := X"0A";
  when "10100100" => data := X"49";
  when "10100101" => data := X"06";
  when "10100110" => data := X"24";
  when "10100111" => data := X"5C";
  when "10101000" => data := X"C2";
  when "10101001" => data := X"D3";
  when "10101010" => data := X"AC";
  when "10101011" => data := X"62";
  when "10101100" => data := X"91";
  when "10101101" => data := X"95";
  when "10101110" => data := X"E4";
  when "10101111" => data := X"79";
  when "10110000" => data := X"E7";
  when "10110001" => data := X"C8";
  when "10110010" => data := X"37";
  when "10110011" => data := X"6D";
  when "10110100" => data := X"8D";
  when "10110101" => data := X"D5";
  when "10110110" => data := X"4E";
  when "10110111" => data := X"A9";
  when "10111000" => data := X"6C";
  when "10111001" => data := X"56";
  when "10111010" => data := X"F4";
  when "10111011" => data := X"EA";
  when "10111100" => data := X"65";
  when "10111101" => data := X"7A";
  when "10111110" => data := X"AE";
  when "10111111" => data := X"08";
  when "11000000" => data := X"BA";
  when "11000001" => data := X"78";
  when "11000010" => data := X"25";
  when "11000011" => data := X"2E";
  when "11000100" => data := X"1C";
  when "11000101" => data := X"A6";
  when "11000110" => data := X"B4";
  when "11000111" => data := X"C6";
  when "11001000" => data := X"E8";
  when "11001001" => data := X"DD";
  when "11001010" => data := X"74";
  when "11001011" => data := X"1F";
  when "11001100" => data := X"4B";
  when "11001101" => data := X"BD";
  when "11001110" => data := X"8B";
  when "11001111" => data := X"8A";
  when "11010000" => data := X"70";
  when "11010001" => data := X"3E";
  when "11010010" => data := X"B5";
  when "11010011" => data := X"66";
  when "11010100" => data := X"48";
  when "11010101" => data := X"03";
  when "11010110" => data := X"F6";
  when "11010111" => data := X"0E";
  when "11011000" => data := X"61";
  when "11011001" => data := X"35";
  when "11011010" => data := X"57";
  when "11011011" => data := X"B9";
  when "11011100" => data := X"86";
  when "11011101" => data := X"C1";
  when "11011110" => data := X"1D";
  when "11011111" => data := X"9E";
  when "11100000" => data := X"E1";
  when "11100001" => data := X"F8";
  when "11100010" => data := X"98";
  when "11100011" => data := X"11";
  when "11100100" => data := X"69";
  when "11100101" => data := X"D9";
  when "11100110" => data := X"8E";
  when "11100111" => data := X"94";
  when "11101000" => data := X"9B";
  when "11101001" => data := X"1E";
  when "11101010" => data := X"87";
  when "11101011" => data := X"E9";
  when "11101100" => data := X"CE";
  when "11101101" => data := X"55";
  when "11101110" => data := X"28";
  when "11101111" => data := X"DF";
  when "11110000" => data := X"8C";
  when "11110001" => data := X"A1";
  when "11110010" => data := X"89";
  when "11110011" => data := X"0D";
  when "11110100" => data := X"BF";
  when "11110101" => data := X"E6";
  when "11110110" => data := X"42";
  when "11110111" => data := X"68";
  when "11111000" => data := X"41";
  when "11111001" => data := X"99";
  when "11111010" => data := X"2D";
  when "11111011" => data := X"0F";
  when "11111100" => data := X"B0";
  when "11111101" => data := X"54";
  when "11111110" => data := X"BB";
  when "11111111" => data := X"16";
  when others => null;  
end case;
data_stdlogic := to_StdLogicVector(data);
return data_stdlogic;
end function sbox_val;


function col_transform(p: state_array_type) return std_logic_vector is
 variable result: std_logic_vector(7 downto 0);
 variable m,n: std_logic_vector(7 downto 0);
 begin 
   if(p(0)(7) = '1') then
     m := (p(0)(6 downto 0) & '0') xor "00011011";
   else
     m := (p(0)(6 downto 0) & '0');
   end if;
   if(p(1)(7) = '1') then
     n := (p(1)(6 downto 0) & '0') xor "00011011" xor p(1);
   else
     n := (p(1)(6 downto 0) & '0') xor p(1);
   end if;
   result := m xor n xor p(2) xor p(3);
   return result;
end function col_transform;

-- combo logic for mix columns
function mix_cols_routine
     (
       a_r0 :state_array_type;
       a_r1 :state_array_type;
       a_r2 :state_array_type;
       a_r3 :state_array_type
     )
return std_logic_vector is
variable b      : std_logic_vector(0 to 127);
variable b0     : state_array_type;
variable b1     : state_array_type;
variable b2     : state_array_type;
variable b3     : state_array_type;
-------------------------------------------------
variable b_0_0  : std_logic_vector(7 downto 0);
variable s_0_0  : state_array_type;
--------------------------------------------------
variable b_0_1  : std_logic_vector(7 downto 0);
variable s_0_1  : state_array_type;
--------------------------------------------------
variable b_0_2  : std_logic_vector(7 downto 0);
variable s_0_2  : state_array_type;
----------------------------------------------
variable b_0_3  : std_logic_vector(7 downto 0);
variable s_0_3  : state_array_type;
----------------------------------------------
variable b_1_0  : std_logic_vector(7 downto 0);
variable s_1_0  : state_array_type;
----------------------------------------------
variable b_1_1  : std_logic_vector(7 downto 0);
variable s_1_1  : state_array_type;
----------------------------------------------
variable b_1_2  : std_logic_vector(7 downto 0);
variable s_1_2  : state_array_type;
----------------------------------------------
variable b_1_3  : std_logic_vector(7 downto 0);
variable s_1_3  : state_array_type;
----------------------------------------------
variable b_2_0  : std_logic_vector(7 downto 0);
variable s_2_0  : state_array_type;
----------------------------------------------
variable b_2_1  : std_logic_vector(7 downto 0);
variable s_2_1  : state_array_type;
----------------------------------------------
variable b_2_2  : std_logic_vector(7 downto 0);
variable s_2_2  : state_array_type;
----------------------------------------------
variable b_2_3  : std_logic_vector(7 downto 0);
variable s_2_3  : state_array_type;
----------------------------------------------
variable b_3_0  : std_logic_vector(7 downto 0);
variable s_3_0  : state_array_type;
----------------------------------------------
variable b_3_1  : std_logic_vector(7 downto 0);
variable s_3_1  : state_array_type;
----------------------------------------------
variable b_3_2  : std_logic_vector(7 downto 0);
variable s_3_2  : state_array_type;
----------------------------------------------
variable b_3_3  : std_logic_vector(7 downto 0);
variable s_3_3  : state_array_type;
--------------------------------------------------
begin
  s_0_0 := a_r0;
  b_0_0 := col_transform(s_0_0);
------------------------------------------------------
  s_0_1 := a_r1;
  b_0_1 := col_transform(s_0_1);
------------------------------------------------------
  s_0_2 := a_r2;
  b_0_2 := col_transform(s_0_2);
------------------------------------------------------
  s_0_3 := a_r3;
  b_0_3 := col_transform(s_0_3);
--****************************************************************
  s_1_0 := (a_r0(1),a_r0(2),a_r0(3),a_r0(0));
  b_1_0 := col_transform(s_1_0);
------------------------------------------------------
  s_1_1 := (a_r1(1),a_r1(2),a_r1(3),a_r1(0));
  b_1_1 := col_transform(s_1_1);
------------------------------------------------------
  s_1_2 := (a_r2(1),a_r2(2),a_r2(3),a_r2(0));
  b_1_2 := col_transform(s_1_2);
------------------------------------------------------
  s_1_3 := (a_r3(1),a_r3(2),a_r3(3),a_r3(0));
  b_1_3 := col_transform(s_1_3);
--****************************************************************
  s_2_0 := (a_r0(2),a_r0(3),a_r0(0),a_r0(1));
  b_2_0 := col_transform(s_2_0);
------------------------------------------------------
  s_2_1 := (a_r1(2),a_r1(3),a_r1(0),a_r1(1));
  b_2_1 := col_transform(s_2_1);
------------------------------------------------------
  s_2_2 := (a_r2(2),a_r2(3),a_r2(0),a_r2(1));
  b_2_2 := col_transform(s_2_2);
------------------------------------------------------
  s_2_3 := (a_r3(2),a_r3(3),a_r3(0),a_r3(1));
  b_2_3 := col_transform(s_2_3);
--****************************************************************
  s_3_0 := (a_r0(3),a_r0(0),a_r0(1),a_r0(2));
  b_3_0 := col_transform(s_3_0);
------------------------------------------------------
  s_3_1 := (a_r1(3),a_r1(0),a_r1(1),a_r1(2));
  b_3_1 := col_transform(s_3_1);
------------------------------------------------------
  s_3_2 := (a_r2(3),a_r2(0),a_r2(1),a_r2(2));
  b_3_2 := col_transform(s_3_2);
------------------------------------------------------
  s_3_3 := (a_r3(3),a_r3(0),a_r3(1),a_r3(2));
  b_3_3 := col_transform(s_3_3);
--****************************************************************

b := (b_0_0 & b_1_0 & b_2_0 & b_3_0 & b_0_1 & b_1_1 & b_2_1 & b_3_1 &
      b_0_2 & b_1_2 & b_2_2 & b_3_2 & b_0_3 & b_1_3 & b_2_3 & b_3_3);
return b;
end function mix_cols_routine;

end package body aes_package;

