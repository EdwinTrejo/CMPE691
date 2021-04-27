library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use work.aes128Pkg.all;

entity aes_128_tb is
end aes_128_tb;

architecture behavioral of aes_128_tb is

  component aes_128
    port (
      clock          : in std_logic;
      reset          : in std_logic;
      data           : in Matrix;
      key            : in Matrix;
      ciphertext     : out Matrix;
      done           : out std_logic;
      faulty         : in std_logic;
      fault_round    : in std_logic_vector (3 downto 0);
      fault_function : in std_logic_vector (1 downto 0);
      fault_word     : in std_logic_vector (1 downto 0);
      fault_byte     : in std_logic_vector (1 downto 0);
      fault_bit      : in std_logic_vector (2 downto 0);
      fault_word2    : in std_logic_vector (1 downto 0);
      fault_byte2    : in std_logic_vector (1 downto 0);
      fault_bit2     : in std_logic_vector (2 downto 0);
      fault_detected : out std_logic
    );
  end component;

  -- signals
  signal clock_sig, reset_sig, done_sig, faulty_sig         : std_logic;
  signal data_sig, key_sig, ciphertext_sig                  : Matrix;
  signal fault_round_sig                                    : std_logic_vector (3 downto 0);
  signal fault_function_sig, fault_word_sig, fault_byte_sig : std_logic_vector (1 downto 0);
  signal fault_word2_sig, fault_byte2_sig                   : std_logic_vector (1 downto 0);
  signal fault_bit_sig, fault_bit2_sig                      : std_logic_vector (2 downto 0);
  signal fault_detected_sig                                 : std_logic := '0';
  signal hex_sig                                            : std_logic_vector(3 downto 0);

begin

  -- uut
  uut : aes_128 port map(clock_sig, reset_sig, data_sig, key_sig, ciphertext_sig, done_sig, faulty_sig, fault_round_sig, fault_function_sig, fault_word_sig, fault_byte_sig, fault_bit_sig, fault_word2_sig, fault_byte2_sig, fault_bit2_sig, fault_detected_sig);

  clock_process : process
  begin
    clock_sig <= '0';
    wait for 20 ns;
    clock_sig <= '1';
    wait for 20 ns;
  end process;

  io_process : process

    --variables
    file infile                       : TEXT is in "in.txt";
    file result_file                  : TEXT is out "out.txt";
    variable good                     : boolean;
    variable L, result_line, out_line : Line;
    variable hex_var, hex_var2        : std_logic_vector (3 downto 0);

  begin

    readline(infile, L);

    hread(L, hex_var, good);
    faulty_sig <= hex_var(0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_round_sig <= hex_var;
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_function_sig <= hex_var(1 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_word_sig <= hex_var(1 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_byte_sig <= hex_var(1 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_bit_sig <= hex_var(2 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_word2_sig <= hex_var(1 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_byte2_sig <= hex_var(1 downto 0);
    wait for 2 ns;

    hread(L, hex_var, good);
    fault_bit2_sig <= hex_var(2 downto 0);
    wait for 2 ns;

    readline(infile, L);
    for idx in 0 to 3 loop
      for idy in 0 to 3 loop
        hread(L, hex_var, good);
        hread(L, hex_var2, good);
        key_sig(idy)(idx) <= hex_var & hex_var2;
      end loop;
    end loop;

    readline(infile, L);
    for idx in 0 to 3 loop
      for idy in 0 to 3 loop
        hread(L, hex_var, good);
        hread(L, hex_var2, good);
        data_sig(idy)(idx) <= hex_var & hex_var2;
      end loop;
    end loop;

    reset_sig <= '0';
    wait for 40 ns;
    reset_sig <= '1';
    wait for 40 ns;
    reset_sig <= '0';

    wait for 900 ns;
    hwrite (result_line, ciphertext_sig(0)(0));
    hwrite (result_line, ciphertext_sig(1)(0));
    hwrite (result_line, ciphertext_sig(2)(0));
    hwrite (result_line, ciphertext_sig(3)(0));
    hwrite (result_line, ciphertext_sig(0)(1));
    hwrite (result_line, ciphertext_sig(1)(1));
    hwrite (result_line, ciphertext_sig(2)(1));
    hwrite (result_line, ciphertext_sig(3)(1));
    hwrite (result_line, ciphertext_sig(0)(2));
    hwrite (result_line, ciphertext_sig(1)(2));
    hwrite (result_line, ciphertext_sig(2)(2));
    hwrite (result_line, ciphertext_sig(3)(2));
    hwrite (result_line, ciphertext_sig(0)(3));
    hwrite (result_line, ciphertext_sig(1)(3));
    hwrite (result_line, ciphertext_sig(2)(3));
    hwrite (result_line, ciphertext_sig(3)(3));
    write (result_line, ' ');
    write (result_line, fault_detected_sig);
    wait for 10 ns;
    writeline (result_file, result_line);

    write (result_line, string'(" "));
    writeline (output, result_line);
    write (result_line, string'("----------------------------------------"));
    writeline (output, result_line);
    write (result_line, string'("Done - ciphertext written to out.txt "));
    writeline (output, result_line);
    write (result_line, string'("----------------------------------------"));
    writeline (output, result_line);

    wait;

  end process;

  --wait;

end;