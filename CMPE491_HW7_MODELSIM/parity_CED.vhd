-------------------------------------------------------------------------------
--! @file       parity_CED.vhd
--! @brief      AES parity_CED operation all
--! @author     Edwin Trejo (etrejo@umbc.edu)
--! @company    United Parcel Service
--! @date       2021-04-20
--! @updated    2021-04-21
--! @platform   Simulation: ModelSim; Synthesis: Synopsys
--! @standard   VHDL'93/02 ?
-------------------------------------------------------------------------------
-- Major Revisions:
-- Date        Version   Author    Description
-- 2021-04-20  1.0       Edwin     Created
-------------------------------------------------------------------------------

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity parity_CED is
  port (
    -- inputs
    RoundState : in Matrix;
    RoundKey   : in Matrix;
    key_index  : in integer;
    -- outputs
    CheckedState : out Matrix);

end entity parity_CED;
architecture Behavioral of parity_CED is
  -- Signals
  signal ROUNDKEYPARITY : Matrix;

begin -- architecture Behavioral

  -----------------------------------------------------------------------------
  -- First Word
  -----------------------------------------------------------------------------
  CheckedState(0)(0) <= RoundState(0)(0) xor RoundKey(0)(0);
  CheckedState(0)(1) <= RoundState(0)(1) xor RoundKey(0)(1);
  CheckedState(0)(2) <= RoundState(0)(2) xor RoundKey(0)(2);
  CheckedState(0)(3) <= RoundState(0)(3) xor RoundKey(0)(3);

  -----------------------------------------------------------------------------
  -- Second Word
  -----------------------------------------------------------------------------
  CheckedState(1)(0) <= RoundState(1)(0) xor RoundKey(1)(0);
  CheckedState(1)(1) <= RoundState(1)(1) xor RoundKey(1)(1);
  CheckedState(1)(2) <= RoundState(1)(2) xor RoundKey(1)(2);
  CheckedState(1)(3) <= RoundState(1)(3) xor RoundKey(1)(3);

  -----------------------------------------------------------------------------
  -- Third Word
  -----------------------------------------------------------------------------
  CheckedState(2)(0) <= RoundState(2)(0) xor RoundKey(2)(0);
  CheckedState(2)(1) <= RoundState(2)(1) xor RoundKey(2)(1);
  CheckedState(2)(2) <= RoundState(2)(2) xor RoundKey(2)(2);
  CheckedState(2)(3) <= RoundState(2)(3) xor RoundKey(2)(3);

  -----------------------------------------------------------------------------
  -- Fourth Word
  -----------------------------------------------------------------------------
  CheckedState(3)(0) <= RoundState(3)(0) xor RoundKey(3)(0);
  CheckedState(3)(1) <= RoundState(3)(1) xor RoundKey(3)(1);
  CheckedState(3)(2) <= RoundState(3)(2) xor RoundKey(3)(2);
  CheckedState(3)(3) <= RoundState(3)(3) xor RoundKey(3)(3);

end architecture Behavioral;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity CED_KEYXOR_STATE is
  port (
    RoundState  : in Matrix;
    RoundKey    : in Matrix;
    RoundParity : out Matrix);
end entity CED_KEYXOR_STATE;
architecture Behavioral of CED_KEYXOR_STATE is

  component CED_KEYXOR_BYTE
    port (
      K : in Byte;
      U : in Byte;
      V : out Byte);
  end component;

begin

  CED_KEYXOR_BYTE_0 : CED_KEYXOR_BYTE port map(RoundKey(0)(0), RoundState(0)(0), RoundParity(0)(0));
  CED_KEYXOR_BYTE_1 : CED_KEYXOR_BYTE port map(RoundKey(0)(1), RoundState(0)(1), RoundParity(0)(1));
  CED_KEYXOR_BYTE_2 : CED_KEYXOR_BYTE port map(RoundKey(0)(2), RoundState(0)(2), RoundParity(0)(2));
  CED_KEYXOR_BYTE_3 : CED_KEYXOR_BYTE port map(RoundKey(0)(3), RoundState(0)(3), RoundParity(0)(3));

  CED_KEYXOR_BYTE_4 : CED_KEYXOR_BYTE port map(RoundKey(1)(0), RoundState(1)(0), RoundParity(1)(0));
  CED_KEYXOR_BYTE_5 : CED_KEYXOR_BYTE port map(RoundKey(1)(1), RoundState(1)(1), RoundParity(1)(1));
  CED_KEYXOR_BYTE_6 : CED_KEYXOR_BYTE port map(RoundKey(1)(2), RoundState(1)(2), RoundParity(1)(2));
  CED_KEYXOR_BYTE_7 : CED_KEYXOR_BYTE port map(RoundKey(1)(3), RoundState(1)(3), RoundParity(1)(3));

  CED_KEYXOR_BYTE_8  : CED_KEYXOR_BYTE port map(RoundKey(2)(0), RoundState(2)(0), RoundParity(2)(0));
  CED_KEYXOR_BYTE_9  : CED_KEYXOR_BYTE port map(RoundKey(2)(1), RoundState(2)(1), RoundParity(2)(1));
  CED_KEYXOR_BYTE_10 : CED_KEYXOR_BYTE port map(RoundKey(2)(2), RoundState(2)(2), RoundParity(2)(2));
  CED_KEYXOR_BYTE_11 : CED_KEYXOR_BYTE port map(RoundKey(2)(3), RoundState(2)(3), RoundParity(2)(3));

  CED_KEYXOR_BYTE_12 : CED_KEYXOR_BYTE port map(RoundKey(3)(0), RoundState(3)(0), RoundParity(3)(0));
  CED_KEYXOR_BYTE_13 : CED_KEYXOR_BYTE port map(RoundKey(3)(1), RoundState(3)(1), RoundParity(3)(1));
  CED_KEYXOR_BYTE_14 : CED_KEYXOR_BYTE port map(RoundKey(3)(2), RoundState(3)(2), RoundParity(3)(2));
  CED_KEYXOR_BYTE_15 : CED_KEYXOR_BYTE port map(RoundKey(3)(3), RoundState(3)(3), RoundParity(3)(3));

end architecture Behavioral;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity CED_KEYXOR_BYTE is
  port (
    --K is round key
    --U is round state
    --V is round parity
    K : in Byte;
    U : in Byte;
    V : out Byte);
end entity CED_KEYXOR_BYTE;
architecture Behavioral of CED_KEYXOR_BYTE is
begin
  V(0) <= K(0) xor U(0);
  V(1) <= K(1) xor U(1);
  V(2) <= K(2) xor U(2);
  V(3) <= K(3) xor U(3);
  V(4) <= K(4) xor U(4);
  V(5) <= K(5) xor U(5);
  V(6) <= K(6) xor U(6);
  V(7) <= K(7) xor U(7);
end architecture Behavioral;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity MatrixParity is
  port (
    P_STATE : in Matrix;
    PX      : out DByte);
end entity MatrixParity;

architecture Behavioral of MatrixParity is

  component ByteParity
    port (
      Byte_In    : in Byte;
      Bit_Parity : out std_logic);
  end component;

  signal PX_temp : Dbyte;

begin

  ByteParity_0  : ByteParity port map(P_STATE(0)(0), PX_temp(0));
  ByteParity_4  : ByteParity port map(P_STATE(1)(0), PX_temp(4));
  ByteParity_8  : ByteParity port map(P_STATE(2)(0), PX_temp(8));
  ByteParity_12 : ByteParity port map(P_STATE(3)(0), PX_temp(12));

  ByteParity_1  : ByteParity port map(P_STATE(0)(1), PX_temp(1));
  ByteParity_5  : ByteParity port map(P_STATE(1)(1), PX_temp(5));
  ByteParity_9  : ByteParity port map(P_STATE(2)(1), PX_temp(9));
  ByteParity_13 : ByteParity port map(P_STATE(3)(1), PX_temp(13));

  ByteParity_2  : ByteParity port map(P_STATE(0)(2), PX_temp(2));
  ByteParity_6  : ByteParity port map(P_STATE(1)(2), PX_temp(6));
  ByteParity_10 : ByteParity port map(P_STATE(2)(2), PX_temp(10));
  ByteParity_14 : ByteParity port map(P_STATE(3)(2), PX_temp(14));

  ByteParity_3  : ByteParity port map(P_STATE(0)(3), PX_temp(3));
  ByteParity_7  : ByteParity port map(P_STATE(1)(3), PX_temp(7));
  ByteParity_11 : ByteParity port map(P_STATE(2)(3), PX_temp(11));
  ByteParity_15 : ByteParity port map(P_STATE(3)(3), PX_temp(15));

  PX <= PX_temp;

end architecture Behavioral;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity ByteParity is

  port (
    Byte_In    : in Byte;
    Bit_Parity : out std_logic);
end entity ByteParity;

architecture Behavioral of ByteParity is

  signal Bit_Parity_sig : std_logic;

begin

  Bit_Parity_sig <= Byte_In(0) xor Byte_In(1) xor Byte_In(2) xor Byte_In(3) xor Byte_In(4) xor Byte_In(5) xor Byte_In(6) xor Byte_In(7);
  Bit_Parity     <= Bit_Parity_sig;

end architecture Behavioral;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity WordParity is
  port (
    Word_In    : in Word;
    Bit_Parity : out std_logic);
end entity;

architecture Behavioral of WordParity is

  component ByteParity
    port (
      Byte_In    : in Byte;
      Bit_Parity : out std_logic);
  end component;

  signal Byte_0, Byte_1, Byte_2, Byte_3                         : Byte;
  signal Bit_Parity_0, Bit_Parity_1, Bit_Parity_2, Bit_Parity_3 : std_logic;

begin

  Byte_0 <= Word_In(0);
  Byte_1 <= Word_In(1);
  Byte_2 <= Word_In(2);
  Byte_3 <= Word_In(3);

  ByteParity_0 : ByteParity port map(Byte_0, Bit_Parity_0);
  ByteParity_1 : ByteParity port map(Byte_1, Bit_Parity_1);
  ByteParity_2 : ByteParity port map(Byte_2, Bit_Parity_2);
  ByteParity_3 : ByteParity port map(Byte_3, Bit_Parity_3);

  Bit_Parity <= Bit_Parity_0 xor Bit_Parity_1 xor Bit_Parity_2 xor Bit_Parity_3;

end architecture;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity DByteParity is
  port (
    DByte_In   : in DByte;
    Bit_Parity : out std_logic);
end entity;

architecture Behavioral of DByteParity is

  component ByteParity
    port (
      Byte_In    : in Byte;
      Bit_Parity : out std_logic);
  end component;

begin

  Bit_Parity <= (DByte_In(0) xor DByte_In(1) xor DByte_In(2) xor DByte_In(3)) xor
    (DByte_In(4) xor DByte_In(5) xor DByte_In(6) xor DByte_In(7)) xor
    (DByte_In(8) xor DByte_In(9) xor DByte_In(10) xor DByte_In(11)) xor
    (DByte_In(12) xor DByte_In(13) xor DByte_In(14) xor DByte_In(15));

end architecture;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity DoubleMatrixParityRows is
  port (
    DoubleState : in DoubleMatrix;
    Bit_Parity  : out std_logic);
end entity DoubleMatrixParityRows;

architecture Behavioral of DoubleMatrixParityRows is

  component WordParity
    port (
      Word_In    : in Word;
      Bit_Parity : out std_logic);
  end component;

  signal word_0_0, word_0_1, word_0_2, word_0_3 : std_logic;
  signal word_1_0, word_1_1, word_1_2, word_1_3 : std_logic;

begin

  WordParity_0_0 : WordParity port map(DoubleState(0)(0), word_0_0);
  WordParity_0_1 : WordParity port map(DoubleState(0)(1), word_0_1);
  WordParity_0_2 : WordParity port map(DoubleState(0)(2), word_0_2);
  WordParity_0_3 : WordParity port map(DoubleState(0)(3), word_0_3);

  WordParity_1_0 : WordParity port map(DoubleState(1)(0), word_1_0);
  WordParity_1_1 : WordParity port map(DoubleState(1)(1), word_1_1);
  WordParity_1_2 : WordParity port map(DoubleState(1)(2), word_1_2);
  WordParity_1_3 : WordParity port map(DoubleState(1)(3), word_1_3);

  Bit_Parity <= (word_0_0 xor word_1_0) xor
    (word_0_1 xor word_1_1) xor
    (word_0_2 xor word_1_2) xor
    (word_0_3 xor word_1_3);

end architecture;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity DoubleMatrixParityColumns is
  port (
    DoubleState : in DoubleMatrix;
    Bit_Parity  : out std_logic);
end entity DoubleMatrixParityColumns;

architecture Behavioral of DoubleMatrixParityColumns is

  component WordParity
    port (
      Word_In    : in Word;
      Bit_Parity : out std_logic);
  end component;

  signal matrix_1, matrix_2                     : Matrix;
  signal word_0_0, word_0_1, word_0_2, word_0_3 : std_logic;
  signal word_1_0, word_1_1, word_1_2, word_1_3 : std_logic;

begin
  -- word byte bit
  -- row col (real specific col)
  matrix_1(0)(0) <= DoubleState(0)(0)(0);
  matrix_1(0)(1) <= DoubleState(0)(1)(0);
  matrix_1(0)(2) <= DoubleState(0)(2)(0);
  matrix_1(0)(3) <= DoubleState(0)(3)(0);

  matrix_1(1)(0) <= DoubleState(0)(0)(1);
  matrix_1(1)(1) <= DoubleState(0)(1)(1);
  matrix_1(1)(2) <= DoubleState(0)(2)(1);
  matrix_1(1)(3) <= DoubleState(0)(3)(1);

  matrix_1(2)(0) <= DoubleState(0)(0)(2);
  matrix_1(2)(1) <= DoubleState(0)(1)(2);
  matrix_1(2)(2) <= DoubleState(0)(2)(2);
  matrix_1(2)(3) <= DoubleState(0)(3)(2);

  matrix_1(3)(0) <= DoubleState(0)(0)(3);
  matrix_1(3)(1) <= DoubleState(0)(1)(3);
  matrix_1(3)(2) <= DoubleState(0)(2)(3);
  matrix_1(3)(3) <= DoubleState(0)(3)(3);

  matrix_2(0)(0) <= DoubleState(1)(0)(0);
  matrix_2(0)(1) <= DoubleState(1)(1)(0);
  matrix_2(0)(2) <= DoubleState(1)(2)(0);
  matrix_2(0)(3) <= DoubleState(1)(3)(0);

  matrix_2(1)(0) <= DoubleState(1)(0)(1);
  matrix_2(1)(1) <= DoubleState(1)(1)(1);
  matrix_2(1)(2) <= DoubleState(1)(2)(1);
  matrix_2(1)(3) <= DoubleState(1)(3)(1);

  matrix_2(2)(0) <= DoubleState(1)(0)(2);
  matrix_2(2)(1) <= DoubleState(1)(1)(2);
  matrix_2(2)(2) <= DoubleState(1)(2)(2);
  matrix_2(2)(3) <= DoubleState(1)(3)(2);

  matrix_2(3)(0) <= DoubleState(1)(0)(3);
  matrix_2(3)(1) <= DoubleState(1)(1)(3);
  matrix_2(3)(2) <= DoubleState(1)(2)(3);
  matrix_2(3)(3) <= DoubleState(1)(3)(3);

  WordParity_0_0 : WordParity port map(matrix_1(0), word_0_0);
  WordParity_0_1 : WordParity port map(matrix_1(1), word_0_1);
  WordParity_0_2 : WordParity port map(matrix_1(2), word_0_2);
  WordParity_0_3 : WordParity port map(matrix_1(3), word_0_3);

  WordParity_1_0 : WordParity port map(matrix_2(0), word_1_0);
  WordParity_1_1 : WordParity port map(matrix_2(1), word_1_1);
  WordParity_1_2 : WordParity port map(matrix_2(2), word_1_2);
  WordParity_1_3 : WordParity port map(matrix_2(3), word_1_3);

  Bit_Parity <= (word_0_0 xor word_1_0) xor
    (word_0_1 xor word_1_1) xor
    (word_0_2 xor word_1_2) xor
    (word_0_3 xor word_1_3);

end architecture;

-- /***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.aes128Pkg.all;

entity KeyXorParity is
  port (
    ParityK    : in DByte;
    ParityU    : in DByte;
    ParityV2   : in DByte;
    Bit_Parity : out std_logic);
end entity KeyXorParity;

architecture Behavioral of KeyXorParity is

begin

  Bit_Parity <= (ParityU(0) xor ParityK(0) xor ParityV2(0)) xor
    (ParityU(1) xor ParityK(1) xor ParityV2(1)) xor
    (ParityU(2) xor ParityK(2) xor ParityV2(2)) xor
    (ParityU(3) xor ParityK(3) xor ParityV2(3)) xor
    (ParityU(4) xor ParityK(4) xor ParityV2(4)) xor
    (ParityU(5) xor ParityK(5) xor ParityV2(5)) xor
    (ParityU(6) xor ParityK(6) xor ParityV2(6)) xor
    (ParityU(7) xor ParityK(7) xor ParityV2(7)) xor
    (ParityU(8) xor ParityK(8) xor ParityV2(8)) xor
    (ParityU(9) xor ParityK(9) xor ParityV2(9)) xor
    (ParityU(10) xor ParityK(10) xor ParityV2(10)) xor
    (ParityU(11) xor ParityK(11) xor ParityV2(11)) xor
    (ParityU(12) xor ParityK(12) xor ParityV2(12)) xor
    (ParityU(13) xor ParityK(13) xor ParityV2(13)) xor
    (ParityU(14) xor ParityK(14) xor ParityV2(14)) xor
    (ParityU(15) xor ParityK(15) xor ParityV2(15));

end architecture;