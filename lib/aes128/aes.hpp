#ifndef AES_ENCRYPT_HPP
#define AES_ENCRYPT_HPP

#include <cstddef>
#include <algorithm>
#include <cstring>

struct rc4_encrypt
{
  typedef std::size_t size_type;

  ~rc4_encrypt()
  {
    std::memset(state_, 0, sizeof(state_));
    x_ = 0;
    y_ = 0;
  }

  void set_key(const void* vkey, size_type key_len)
  {
    x_ = 0;
    y_ = 0;
    const unsigned char* key = static_cast<const unsigned char*>(vkey);
    unsigned char index1 = 0;
    unsigned char index2 = 0;

    for (int i = 0; i < 256; ++i)
      state_[i] = (unsigned char)i;

    for (int i = 0; i < 256; ++i)
    {
      index2 = (key[index1] + state_[i] + index2) % 256;
      std::swap(state_[i], state_[index2]);
      index1 = (index1 + 1) % key_len;
    }
  }

  void encrypt(const void* vin, void* vout, size_type len)
  {
    const unsigned char* in = static_cast<const unsigned char*>(vin);
    unsigned char* out = static_cast<unsigned char*>(vout);
    unsigned char xor_index;
    unsigned char x = x_;
    unsigned char y = y_;

    for (size_type i = 0; i < len; ++i)
    {
      x = (x + 1) % 256;
      y = (state_[x] + y) % 256;
      std::swap(state_[x], state_[y]);

      xor_index = state_[x] + (state_[y]) % 256;

      out[i] = in[i] ^ state_[xor_index];
    }
    x_ = x;
    y_ = y;
  }

  void decrypt(const void* in, void* out, size_type len)
  {
    encrypt(in, out, len);
  }

private:

  unsigned char state_[256];
  unsigned char x_, y_;
};


namespace
{
  static const unsigned char log_[256] = {
    0,   0,  25,   1,  50,   2,  26, 198,  75, 199,  27, 104,  51, 238, 223,   3, 
    100,   4, 224,  14,  52, 141, 129, 239,  76, 113,   8, 200, 248, 105,  28, 193, 
    125, 194,  29, 181, 249, 185,  39, 106,  77, 228, 166, 114, 154, 201,   9, 120, 
    101,  47, 138,   5,  33,  15, 225,  36,  18, 240, 130,  69,  53, 147, 218, 142, 
    150, 143, 219, 189,  54, 208, 206, 148,  19,  92, 210, 241,  64,  70, 131,  56, 
    102, 221, 253,  48, 191,   6, 139,  98, 179,  37, 226, 152,  34, 136, 145,  16, 
    126, 110,  72, 195, 163, 182,  30,  66,  58, 107,  40,  84, 250, 133,  61, 186, 
    43, 121,  10,  21, 155, 159,  94, 202,  78, 212, 172, 229, 243, 115, 167,  87, 
    175,  88, 168,  80, 244, 234, 214, 116,  79, 174, 233, 213, 231, 230, 173, 232, 
    44, 215, 117, 122, 235,  22,  11, 245,  89, 203,  95, 176, 156, 169,  81, 160, 
    127,  12, 246, 111,  23, 196,  73, 236, 216,  67,  31,  45, 164, 118, 123, 183, 
    204, 187,  62,  90, 251,  96, 177, 134,  59,  82, 161, 108, 170,  85,  41, 157, 
    151, 178, 135, 144,  97, 190, 220, 252, 188, 149, 207, 205,  55,  63,  91, 209, 
    83,  57, 132,  60,  65, 162, 109,  71,  20,  42, 158,  93,  86, 242, 211, 171, 
    68,  17, 146, 217,  35,  32,  46, 137, 180, 124, 184,  38, 119, 153, 227, 165, 
    103,  74, 237, 222, 197,  49, 254,  24,  13,  99, 140, 128, 192, 247, 112,   7, 
  };

  static const unsigned char pow_[256] = {
    1,   3,   5,  15,  17,  51,  85, 255,  26,  46, 114, 150, 161, 248,  19,  53, 
    95, 225,  56,  72, 216, 115, 149, 164, 247,   2,   6,  10,  30,  34, 102, 170, 
    229,  52,  92, 228,  55,  89, 235,  38, 106, 190, 217, 112, 144, 171, 230,  49, 
    83, 245,   4,  12,  20,  60,  68, 204,  79, 209, 104, 184, 211, 110, 178, 205, 
    76, 212, 103, 169, 224,  59,  77, 215,  98, 166, 241,   8,  24,  40, 120, 136, 
    131, 158, 185, 208, 107, 189, 220, 127, 129, 152, 179, 206,  73, 219, 118, 154, 
    181, 196,  87, 249,  16,  48,  80, 240,  11,  29,  39, 105, 187, 214,  97, 163, 
    254,  25,  43, 125, 135, 146, 173, 236,  47, 113, 147, 174, 233,  32,  96, 160, 
    251,  22,  58,  78, 210, 109, 183, 194,  93, 231,  50,  86, 250,  21,  63,  65, 
    195,  94, 226,  61,  71, 201,  64, 192,  91, 237,  44, 116, 156, 191, 218, 117, 
    159, 186, 213, 100, 172, 239,  42, 126, 130, 157, 188, 223, 122, 142, 137, 128, 
    155, 182, 193,  88, 232,  35, 101, 175, 234,  37, 111, 177, 200,  67, 197,  84, 
    252,  31,  33,  99, 165, 244,   7,   9,  27,  45, 119, 153, 176, 203,  70, 202, 
    69, 207,  74, 222, 121, 139, 134, 145, 168, 227,  62,  66, 198,  81, 243,  14, 
    18,  54,  90, 238,  41, 123, 141, 140, 143, 138, 133, 148, 167, 242,  13,  23, 
    57,  75, 221, 124, 132, 151, 162, 253,  28,  36, 108, 180, 199,  82, 246,   1 
  };

  static const unsigned char sbox_[256] = {
    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
  };

  static const unsigned char inv_sbox_[256] = {
    0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
    0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
    0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
    0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
    0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
    0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
    0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
    0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
    0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
    0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
    0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
    0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
    0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
    0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
    0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
    0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
  };

  static const unsigned char mm_[16] = {
    0x02, 0x03, 0x01, 0x01, 
    0x01, 0x02, 0x03, 0x01, 
    0x01, 0x01, 0x02, 0x03, 
    0x03, 0x01, 0x01, 0x02
  };

  static const unsigned char inv_mm_[16] = {
    0x0e, 0x0b, 0x0d, 0x09,
    0x09, 0x0e, 0x0b, 0x0d,
    0x0d, 0x09, 0x0e, 0x0b,
    0x0b, 0x0d, 0x09, 0x0e
  };

  static const unsigned int rcon_[30] = { 
    0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
    0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc,
    0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa,
    0xef, 0xc5, 0x91
  };
}


template<
  int K, // key length in bits
  int B  // block size in bits
>
struct aes_encrypt
{

  static const int key_length = K;
  static const int block_size = B;

  aes_encrypt()
  {
	 std::memset(w_, 0, sizeof(w_));
  }

  ~aes_encrypt();

  void set_key(const void* key, unsigned int len = K / 8)
  {
    expand_key(key);
  }
  void encrypt_block(const void* in, void* out);
  void decrypt_block(const void* in, void* out);
  void encrypt(const void* in, void* out, unsigned int n_block);
  void decrypt(const void* in, void* out, unsigned int n_block);
	
private:

  typedef unsigned int word_type;

  static const int Nk = K / 32;
  static const int Nb = B / 32;
  static const int Nr = (Nk > Nb ? Nk : Nb) + 6;
  static const int round_key_length = Nb * (Nr + 1);
  static const int shift_offsets[3];
  static const int inv_shift_offsets[3];

  word_type w_[round_key_length]; // the expanded key buffer

  void apply_round(int                  round,
                   unsigned char*       state,
                   const word_type*     w,
                   const unsigned char* sbox,
                   const int*           offsets,
                   const unsigned char* mm) const;
  
  void sub_bytes(unsigned char* state, const unsigned char* sbox) const;
  void shift_rows(unsigned char* state, const int* offsets) const;
  void mix_columns(unsigned char* state, const unsigned char* matrix) const;
  void add_round_key(unsigned char* state, const word_type* round_key) const;

  void expand_key(const void* key);

  unsigned char mul(unsigned char x, unsigned char y) const
  {
	  if (x && y) return pow_[(log_[x] + log_[y]) % 255];
	  else return 0;
  }

  static word_type sub_word(const unsigned char* sbox, word_type x)
  {
    unsigned char* y = reinterpret_cast<unsigned char*>(&x);
    for (int i = 0; i < 4; ++i)
      y[i] = sbox[y[i]];
    return x;
  }

  static word_type rotate_left(word_type x)
  {
    unsigned char c;
    c = reinterpret_cast<unsigned char*>(&x)[0];
    for (int i = 0; i < 3; i++)
        reinterpret_cast<unsigned char*>(&x)[i] = reinterpret_cast<unsigned char*>(&x)[i+1];
    reinterpret_cast<unsigned char*>(&x)[3] = c;
    return x;
  }
};


template<int K, int B>
const int aes_encrypt<K, B>::shift_offsets[3] =
{
  1,
  Nb == 8 ? 3 : 2,
  Nb > 6 ? 4 : 3
};

template<int K, int B>
const int aes_encrypt<K, B>::inv_shift_offsets[3] =
{
  Nb - 1,
  Nb == 8 ? 5 : Nb - 2,
  Nb == 8 ? 4 : Nb == 7 ? 3 : Nb - 3
};

template<int K, int B>
aes_encrypt<K, B>::~aes_encrypt()
{
  std::memset(w_, 0, sizeof(w_));
}

template<int K, int B>
void aes_encrypt<K, B>::apply_round(int round,
                                        unsigned char* state,
                                        const word_type* w,
                                        const unsigned char* sbox,
                                        const int* offsets,
                                        const unsigned char* mm) const
{
  sub_bytes(state, sbox);         
  shift_rows(state, offsets);     
  mix_columns(state, mm); 
  add_round_key(state, w + round * Nb);
}

template<int K, int B>
void aes_encrypt<K, B>::encrypt_block(const void* vin, void* vout)
{
  unsigned char state[4 * Nb] = {0};
  std::memcpy(state, vin, 4 * Nb);
  
  add_round_key(state, w_);

  for (int round = 1; round < Nr; ++round)
    apply_round(round, state, w_, sbox_, shift_offsets, mm_);

  sub_bytes(state, sbox_);
  shift_rows(state, shift_offsets);
  add_round_key(state, w_ + Nr * Nb);
  
  std::memcpy(vout, state, 4 * Nb);
}

template<int K, int B>
void aes_encrypt<K, B>::decrypt_block(const void* vin, void* vout)
{
  unsigned char state[4 * Nb] = {0};
  std::memcpy(state, vin, 4 * Nb);

  word_type w[round_key_length] = {0};
  std::memcpy(w, w_, sizeof(w));

  for (int round = 1; round < Nr; ++round)
  {
    unsigned char* s = reinterpret_cast<unsigned char*>(w + round * Nb);
    mix_columns(s, inv_mm_);
  }

  add_round_key(state, w + Nr * Nb);

  for (int round = Nr - 1; round > 0; --round)
    apply_round(round, state, w, inv_sbox_, inv_shift_offsets, inv_mm_);

  sub_bytes(state, inv_sbox_);
  shift_rows(state, inv_shift_offsets);
  add_round_key(state, w);

  std::memcpy(vout, state, 4 * Nb);
}

template<int K, int B>
void aes_encrypt<K, B>::encrypt(const void* in, void* out, unsigned int n_block)
{
  if (0 == n_block) return;

  unsigned int block_size = 4 * Nb;
  const char* block_in = (const char*)in;
  char* block_out = (char*)out;

  // ECB mode
  while (n_block)
  {
    encrypt_block(block_in, block_out);
    block_in += block_size;
    block_out += block_size;
    --n_block;
  }

  //// CBC mode
  //unsigned char buffer[64];
  //memset(buffer, 0, sizeof(buffer)); // clear out - todo - allow setting the Initialization Vector - needed for security
  //while (n_block)
  //{
  //  for (unsigned int pos = 0; pos < block_size; ++pos)
  //    buffer[pos] ^= *block_in++;
  //  encrypt_block(buffer, block_out);
  //  memcpy(buffer, block_out, block_size);
  //  block_out += block_size;
  //  --n_block;
  //}
}
  
template<int K, int B>
void aes_encrypt<K, B>::decrypt(const void* in, void* out, unsigned int n_block)
{
  if (0 == n_block) return;

  unsigned int block_size = 4 * Nb;
  const char* block_in = (const char*)in;
  char* block_out = (char*)out;

  // ECB mode
  while (n_block)
  {
    decrypt_block(block_in, block_out);
    block_in += block_size;
    block_out += block_size;
    --n_block;
  }

  // CBC mode
  //unsigned char buffer[64];
  //memset(buffer, 0, sizeof(buffer)); // clear out - todo - allow setting the Initialization Vector - needed for security
  //decrypt_block(block_in, block_out); // do first block
  //for (unsigned int pos = 0; pos < block_size; ++pos)
  //  *block_out++ ^= buffer[pos];
  //block_in += block_size;
  //n_block--;

  //while (n_block)
  //{
  //  decrypt_block(block_in, block_out); // do first block
  //  for (unsigned int pos = 0; pos < block_size; ++pos)
  //    *block_out++ ^= *(block_in - block_size + pos);
  //  block_in += block_size;
  //  --n_block;
  //}
}

template<int K, int B>
void aes_encrypt<K, B>::sub_bytes(
    unsigned char* state, const unsigned char* sbox) const
{
  for (int i = 0; i < 4 * Nb; ++i)
    state[i] = sbox[state[i]];
}

template<int K, int B>
void aes_encrypt<K, B>::shift_rows(
    unsigned char* state, const int* offset) const
{
	unsigned char tmp[Nb] = {0};
  // row 0 never gets shifted
  for (int row = 1; row < 4; ++row)
  {
    const int off = offset[row - 1];
    int i = 0;
    for (; i < off; ++i)
      tmp[i] = state[i * 4 + row];
    for (i = 0; i < Nb - 1; ++i)
      state[i * 4 + row] = state[(i + off) * 4 + row];
    for (i = 0; i < off; ++i)
      state[(Nb - 1 - i) * 4 + row] = tmp[off - 1 - i];
  }
}

template<int K, int B>
void aes_encrypt<K, B>::mix_columns(unsigned char* state, const unsigned char* mm) const
{
  unsigned char tmp[4 * Nb] = {0};

  for (int col = 0; col < Nb; ++col)
    for (int row = 0; row < 4; ++row)
      for (int k = 0; k < 4; ++k)
        tmp[col * 4 + row] ^= mul(mm[row * 4 + k], state[col * 4 + k]);

  std::memcpy(state, tmp, 4 * Nb);
}

template<int K, int B>
void aes_encrypt<K, B>::add_round_key(
    unsigned char* state, const word_type* round_key) const
{
  for (int i = 0; i < Nb * 4; ++i)
    state[i] ^= reinterpret_cast<const unsigned char*>(round_key)[i];
}
#pragma warning( push )
#pragma warning(disable:4127)
#pragma warning(disable:6326)

template<int K, int B>
void aes_encrypt<K, B>::expand_key(const void* vkey)
{
  const unsigned char* key = static_cast<const unsigned char*>(vkey);

  // the first Nk words are the original key
  std::memcpy(w_, key, Nk * 4);

  for (int i = 0; i < Nk; ++i)
    w_[i] = key[4*i] | key[4*i+1] << 8 | key[4*i+2] << 16 | key[4*i+3] << 24;

  for (int i = Nk; i < round_key_length; ++i)
  {
    word_type tmp = w_[i - 1];
    if ((i % Nk) == 0)
      tmp = sub_word(sbox_, rotate_left(tmp)) ^ rcon_[i / Nk - 1];
    else if (Nk > 6 && (i % Nk) == 4)
      tmp = sub_word(sbox_, tmp);
    w_[i] = w_[i - Nk] ^ tmp;
  }
}
#pragma warning( pop )

#endif // AES_ENCRYPT_HPP
