
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use work.aes128Pkg.all;

entity sbox_128 is
  port (
    --! @brief Input to the S-box.
    --! @brief Substituted output of the S-box.
    -- parity of each byte and sbox byte
    In_DI_128       : in Matrix;
    Out_DO_128      : out Matrix;
    ParityCheckBits : out DByte);
end sbox_128;
architecture behavioral of sbox_128 is

  component sbox
    port (
      --! @brief Input to the S-box.
      --! @brief Substituted output of the S-box.
      In_DI            : in Byte;
      Out_DO           : out Byte;
      SBOX_Byte_Parity : out std_logic);
  end component;

  --signals
  signal In_DI_sig, Out_DO_sig  : Matrix;
  signal SBOX_Matrix_Parity_sig : DByte;

begin

  In_DI_sig <= In_DI_128;

  sbox_0 : sbox port map(In_DI_sig(0)(0), Out_DO_sig(0)(0), SBOX_Matrix_Parity_sig(0));
  sbox_1 : sbox port map(In_DI_sig(0)(1), Out_DO_sig(0)(1), SBOX_Matrix_Parity_sig(1));
  sbox_2 : sbox port map(In_DI_sig(0)(2), Out_DO_sig(0)(2), SBOX_Matrix_Parity_sig(2));
  sbox_3 : sbox port map(In_DI_sig(0)(3), Out_DO_sig(0)(3), SBOX_Matrix_Parity_sig(3));

  sbox_4 : sbox port map(In_DI_sig(1)(0), Out_DO_sig(1)(0), SBOX_Matrix_Parity_sig(4));
  sbox_5 : sbox port map(In_DI_sig(1)(1), Out_DO_sig(1)(1), SBOX_Matrix_Parity_sig(5));
  sbox_6 : sbox port map(In_DI_sig(1)(2), Out_DO_sig(1)(2), SBOX_Matrix_Parity_sig(6));
  sbox_7 : sbox port map(In_DI_sig(1)(3), Out_DO_sig(1)(3), SBOX_Matrix_Parity_sig(7));

  sbox_8  : sbox port map(In_DI_sig(2)(0), Out_DO_sig(2)(0), SBOX_Matrix_Parity_sig(8));
  sbox_9  : sbox port map(In_DI_sig(2)(1), Out_DO_sig(2)(1), SBOX_Matrix_Parity_sig(9));
  sbox_10 : sbox port map(In_DI_sig(2)(2), Out_DO_sig(2)(2), SBOX_Matrix_Parity_sig(10));
  sbox_11 : sbox port map(In_DI_sig(2)(3), Out_DO_sig(2)(3), SBOX_Matrix_Parity_sig(11));

  sbox_12 : sbox port map(In_DI_sig(3)(0), Out_DO_sig(3)(0), SBOX_Matrix_Parity_sig(12));
  sbox_13 : sbox port map(In_DI_sig(3)(1), Out_DO_sig(3)(1), SBOX_Matrix_Parity_sig(13));
  sbox_14 : sbox port map(In_DI_sig(3)(2), Out_DO_sig(3)(2), SBOX_Matrix_Parity_sig(14));
  sbox_15 : sbox port map(In_DI_sig(3)(3), Out_DO_sig(3)(3), SBOX_Matrix_Parity_sig(15));

  Out_DO_128      <= Out_DO_sig;
  ParityCheckBits <= SBOX_Matrix_Parity_sig;

end;