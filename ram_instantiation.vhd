-- Initializing Block RAM (Single-Port Block RAM)

library ieee;

use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

entity ram_mult_lookup is
generic (
addr_length: integer := 9
);
port(

clk  : in  std_logic;

addr : in  unsigned(addr_length-1 downto 0) := (others => '0');

data_out   : out unsigned((2* addr_length)-1 downto 0) := (others => '0')

);

end ram_mult_lookup;

architecture syn of ram_mult_lookup is

type ram_type is array (0 to (2**addr_length)-1) of unsigned ((2*addr_length)-1 downto 0);

signal RAM : ram_type := (
            "000000000000000000", -- value: 0 squared value: 0
            "000000000000000001", -- value: 1 squared value: 1
            "000000000000000100", -- value: 2 squared value: 4
            "000000000000001001", -- value: 3 squared value: 9
            "000000000000010000", -- value: 4 squared value: 16
            "000000000000011001", -- value: 5 squared value: 25
            "000000000000100100", -- value: 6 squared value: 36
            "000000000000110001", -- value: 7 squared value: 49
            "000000000001000000", -- value: 8 squared value: 64
            "000000000001010001", -- value: 9 squared value: 81
            "000000000001100100", -- value: 10 squared value: 100
            "000000000001111001", -- value: 11 squared value: 121
            "000000000010010000", -- value: 12 squared value: 144
            "000000000010101001", -- value: 13 squared value: 169
            "000000000011000100", -- value: 14 squared value: 196
            "000000000011100001", -- value: 15 squared value: 225
            "000000000100000000", -- value: 16 squared value: 256
            "000000000100100001", -- value: 17 squared value: 289
            "000000000101000100", -- value: 18 squared value: 324
            "000000000101101001", -- value: 19 squared value: 361
            "000000000110010000", -- value: 20 squared value: 400
            "000000000110111001", -- value: 21 squared value: 441
            "000000000111100100", -- value: 22 squared value: 484
            "000000001000010001", -- value: 23 squared value: 529
            "000000001001000000", -- value: 24 squared value: 576
            "000000001001110001", -- value: 25 squared value: 625
            "000000001010100100", -- value: 26 squared value: 676
            "000000001011011001", -- value: 27 squared value: 729
            "000000001100010000", -- value: 28 squared value: 784
            "000000001101001001", -- value: 29 squared value: 841
            "000000001110000100", -- value: 30 squared value: 900
            "000000001111000001", -- value: 31 squared value: 961
            "000000010000000000", -- value: 32 squared value: 1024
            "000000010001000001", -- value: 33 squared value: 1089
            "000000010010000100", -- value: 34 squared value: 1156
            "000000010011001001", -- value: 35 squared value: 1225
            "000000010100010000", -- value: 36 squared value: 1296
            "000000010101011001", -- value: 37 squared value: 1369
            "000000010110100100", -- value: 38 squared value: 1444
            "000000010111110001", -- value: 39 squared value: 1521
            "000000011001000000", -- value: 40 squared value: 1600
            "000000011010010001", -- value: 41 squared value: 1681
            "000000011011100100", -- value: 42 squared value: 1764
            "000000011100111001", -- value: 43 squared value: 1849
            "000000011110010000", -- value: 44 squared value: 1936
            "000000011111101001", -- value: 45 squared value: 2025
            "000000100001000100", -- value: 46 squared value: 2116
            "000000100010100001", -- value: 47 squared value: 2209
            "000000100100000000", -- value: 48 squared value: 2304
            "000000100101100001", -- value: 49 squared value: 2401
            "000000100111000100", -- value: 50 squared value: 2500
            "000000101000101001", -- value: 51 squared value: 2601
            "000000101010010000", -- value: 52 squared value: 2704
            "000000101011111001", -- value: 53 squared value: 2809
            "000000101101100100", -- value: 54 squared value: 2916
            "000000101111010001", -- value: 55 squared value: 3025
            "000000110001000000", -- value: 56 squared value: 3136
            "000000110010110001", -- value: 57 squared value: 3249
            "000000110100100100", -- value: 58 squared value: 3364
            "000000110110011001", -- value: 59 squared value: 3481
            "000000111000010000", -- value: 60 squared value: 3600
            "000000111010001001", -- value: 61 squared value: 3721
            "000000111100000100", -- value: 62 squared value: 3844
            "000000111110000001", -- value: 63 squared value: 3969
            "000001000000000000", -- value: 64 squared value: 4096
            "000001000010000001", -- value: 65 squared value: 4225
            "000001000100000100", -- value: 66 squared value: 4356
            "000001000110001001", -- value: 67 squared value: 4489
            "000001001000010000", -- value: 68 squared value: 4624
            "000001001010011001", -- value: 69 squared value: 4761
            "000001001100100100", -- value: 70 squared value: 4900
            "000001001110110001", -- value: 71 squared value: 5041
            "000001010001000000", -- value: 72 squared value: 5184
            "000001010011010001", -- value: 73 squared value: 5329
            "000001010101100100", -- value: 74 squared value: 5476
            "000001010111111001", -- value: 75 squared value: 5625
            "000001011010010000", -- value: 76 squared value: 5776
            "000001011100101001", -- value: 77 squared value: 5929
            "000001011111000100", -- value: 78 squared value: 6084
            "000001100001100001", -- value: 79 squared value: 6241
            "000001100100000000", -- value: 80 squared value: 6400
            "000001100110100001", -- value: 81 squared value: 6561
            "000001101001000100", -- value: 82 squared value: 6724
            "000001101011101001", -- value: 83 squared value: 6889
            "000001101110010000", -- value: 84 squared value: 7056
            "000001110000111001", -- value: 85 squared value: 7225
            "000001110011100100", -- value: 86 squared value: 7396
            "000001110110010001", -- value: 87 squared value: 7569
            "000001111001000000", -- value: 88 squared value: 7744
            "000001111011110001", -- value: 89 squared value: 7921
            "000001111110100100", -- value: 90 squared value: 8100
            "000010000001011001", -- value: 91 squared value: 8281
            "000010000100010000", -- value: 92 squared value: 8464
            "000010000111001001", -- value: 93 squared value: 8649
            "000010001010000100", -- value: 94 squared value: 8836
            "000010001101000001", -- value: 95 squared value: 9025
            "000010010000000000", -- value: 96 squared value: 9216
            "000010010011000001", -- value: 97 squared value: 9409
            "000010010110000100", -- value: 98 squared value: 9604
            "000010011001001001", -- value: 99 squared value: 9801
            "000010011100010000", -- value: 100 squared value: 10000
            "000010011111011001", -- value: 101 squared value: 10201
            "000010100010100100", -- value: 102 squared value: 10404
            "000010100101110001", -- value: 103 squared value: 10609
            "000010101001000000", -- value: 104 squared value: 10816
            "000010101100010001", -- value: 105 squared value: 11025
            "000010101111100100", -- value: 106 squared value: 11236
            "000010110010111001", -- value: 107 squared value: 11449
            "000010110110010000", -- value: 108 squared value: 11664
            "000010111001101001", -- value: 109 squared value: 11881
            "000010111101000100", -- value: 110 squared value: 12100
            "000011000000100001", -- value: 111 squared value: 12321
            "000011000100000000", -- value: 112 squared value: 12544
            "000011000111100001", -- value: 113 squared value: 12769
            "000011001011000100", -- value: 114 squared value: 12996
            "000011001110101001", -- value: 115 squared value: 13225
            "000011010010010000", -- value: 116 squared value: 13456
            "000011010101111001", -- value: 117 squared value: 13689
            "000011011001100100", -- value: 118 squared value: 13924
            "000011011101010001", -- value: 119 squared value: 14161
            "000011100001000000", -- value: 120 squared value: 14400
            "000011100100110001", -- value: 121 squared value: 14641
            "000011101000100100", -- value: 122 squared value: 14884
            "000011101100011001", -- value: 123 squared value: 15129
            "000011110000010000", -- value: 124 squared value: 15376
            "000011110100001001", -- value: 125 squared value: 15625
            "000011111000000100", -- value: 126 squared value: 15876
            "000011111100000001", -- value: 127 squared value: 16129
            "000100000000000000", -- value: 128 squared value: 16384
            "000100000100000001", -- value: 129 squared value: 16641
            "000100001000000100", -- value: 130 squared value: 16900
            "000100001100001001", -- value: 131 squared value: 17161
            "000100010000010000", -- value: 132 squared value: 17424
            "000100010100011001", -- value: 133 squared value: 17689
            "000100011000100100", -- value: 134 squared value: 17956
            "000100011100110001", -- value: 135 squared value: 18225
            "000100100001000000", -- value: 136 squared value: 18496
            "000100100101010001", -- value: 137 squared value: 18769
            "000100101001100100", -- value: 138 squared value: 19044
            "000100101101111001", -- value: 139 squared value: 19321
            "000100110010010000", -- value: 140 squared value: 19600
            "000100110110101001", -- value: 141 squared value: 19881
            "000100111011000100", -- value: 142 squared value: 20164
            "000100111111100001", -- value: 143 squared value: 20449
            "000101000100000000", -- value: 144 squared value: 20736
            "000101001000100001", -- value: 145 squared value: 21025
            "000101001101000100", -- value: 146 squared value: 21316
            "000101010001101001", -- value: 147 squared value: 21609
            "000101010110010000", -- value: 148 squared value: 21904
            "000101011010111001", -- value: 149 squared value: 22201
            "000101011111100100", -- value: 150 squared value: 22500
            "000101100100010001", -- value: 151 squared value: 22801
            "000101101001000000", -- value: 152 squared value: 23104
            "000101101101110001", -- value: 153 squared value: 23409
            "000101110010100100", -- value: 154 squared value: 23716
            "000101110111011001", -- value: 155 squared value: 24025
            "000101111100010000", -- value: 156 squared value: 24336
            "000110000001001001", -- value: 157 squared value: 24649
            "000110000110000100", -- value: 158 squared value: 24964
            "000110001011000001", -- value: 159 squared value: 25281
            "000110010000000000", -- value: 160 squared value: 25600
            "000110010101000001", -- value: 161 squared value: 25921
            "000110011010000100", -- value: 162 squared value: 26244
            "000110011111001001", -- value: 163 squared value: 26569
            "000110100100010000", -- value: 164 squared value: 26896
            "000110101001011001", -- value: 165 squared value: 27225
            "000110101110100100", -- value: 166 squared value: 27556
            "000110110011110001", -- value: 167 squared value: 27889
            "000110111001000000", -- value: 168 squared value: 28224
            "000110111110010001", -- value: 169 squared value: 28561
            "000111000011100100", -- value: 170 squared value: 28900
            "000111001000111001", -- value: 171 squared value: 29241
            "000111001110010000", -- value: 172 squared value: 29584
            "000111010011101001", -- value: 173 squared value: 29929
            "000111011001000100", -- value: 174 squared value: 30276
            "000111011110100001", -- value: 175 squared value: 30625
            "000111100100000000", -- value: 176 squared value: 30976
            "000111101001100001", -- value: 177 squared value: 31329
            "000111101111000100", -- value: 178 squared value: 31684
            "000111110100101001", -- value: 179 squared value: 32041
            "000111111010010000", -- value: 180 squared value: 32400
            "000111111111111001", -- value: 181 squared value: 32761
            "001000000101100100", -- value: 182 squared value: 33124
            "001000001011010001", -- value: 183 squared value: 33489
            "001000010001000000", -- value: 184 squared value: 33856
            "001000010110110001", -- value: 185 squared value: 34225
            "001000011100100100", -- value: 186 squared value: 34596
            "001000100010011001", -- value: 187 squared value: 34969
            "001000101000010000", -- value: 188 squared value: 35344
            "001000101110001001", -- value: 189 squared value: 35721
            "001000110100000100", -- value: 190 squared value: 36100
            "001000111010000001", -- value: 191 squared value: 36481
            "001001000000000000", -- value: 192 squared value: 36864
            "001001000110000001", -- value: 193 squared value: 37249
            "001001001100000100", -- value: 194 squared value: 37636
            "001001010010001001", -- value: 195 squared value: 38025
            "001001011000010000", -- value: 196 squared value: 38416
            "001001011110011001", -- value: 197 squared value: 38809
            "001001100100100100", -- value: 198 squared value: 39204
            "001001101010110001", -- value: 199 squared value: 39601
            "001001110001000000", -- value: 200 squared value: 40000
            "001001110111010001", -- value: 201 squared value: 40401
            "001001111101100100", -- value: 202 squared value: 40804
            "001010000011111001", -- value: 203 squared value: 41209
            "001010001010010000", -- value: 204 squared value: 41616
            "001010010000101001", -- value: 205 squared value: 42025
            "001010010111000100", -- value: 206 squared value: 42436
            "001010011101100001", -- value: 207 squared value: 42849
            "001010100100000000", -- value: 208 squared value: 43264
            "001010101010100001", -- value: 209 squared value: 43681
            "001010110001000100", -- value: 210 squared value: 44100
            "001010110111101001", -- value: 211 squared value: 44521
            "001010111110010000", -- value: 212 squared value: 44944
            "001011000100111001", -- value: 213 squared value: 45369
            "001011001011100100", -- value: 214 squared value: 45796
            "001011010010010001", -- value: 215 squared value: 46225
            "001011011001000000", -- value: 216 squared value: 46656
            "001011011111110001", -- value: 217 squared value: 47089
            "001011100110100100", -- value: 218 squared value: 47524
            "001011101101011001", -- value: 219 squared value: 47961
            "001011110100010000", -- value: 220 squared value: 48400
            "001011111011001001", -- value: 221 squared value: 48841
            "001100000010000100", -- value: 222 squared value: 49284
            "001100001001000001", -- value: 223 squared value: 49729
            "001100010000000000", -- value: 224 squared value: 50176
            "001100010111000001", -- value: 225 squared value: 50625
            "001100011110000100", -- value: 226 squared value: 51076
            "001100100101001001", -- value: 227 squared value: 51529
            "001100101100010000", -- value: 228 squared value: 51984
            "001100110011011001", -- value: 229 squared value: 52441
            "001100111010100100", -- value: 230 squared value: 52900
            "001101000001110001", -- value: 231 squared value: 53361
            "001101001001000000", -- value: 232 squared value: 53824
            "001101010000010001", -- value: 233 squared value: 54289
            "001101010111100100", -- value: 234 squared value: 54756
            "001101011110111001", -- value: 235 squared value: 55225
            "001101100110010000", -- value: 236 squared value: 55696
            "001101101101101001", -- value: 237 squared value: 56169
            "001101110101000100", -- value: 238 squared value: 56644
            "001101111100100001", -- value: 239 squared value: 57121
            "001110000100000000", -- value: 240 squared value: 57600
            "001110001011100001", -- value: 241 squared value: 58081
            "001110010011000100", -- value: 242 squared value: 58564
            "001110011010101001", -- value: 243 squared value: 59049
            "001110100010010000", -- value: 244 squared value: 59536
            "001110101001111001", -- value: 245 squared value: 60025
            "001110110001100100", -- value: 246 squared value: 60516
            "001110111001010001", -- value: 247 squared value: 61009
            "001111000001000000", -- value: 248 squared value: 61504
            "001111001000110001", -- value: 249 squared value: 62001
            "001111010000100100", -- value: 250 squared value: 62500
            "001111011000011001", -- value: 251 squared value: 63001
            "001111100000010000", -- value: 252 squared value: 63504
            "001111101000001001", -- value: 253 squared value: 64009
            "001111110000000100", -- value: 254 squared value: 64516
            "001111111000000001", -- value: 255 squared value: 65025
            "010000000000000000", -- value: 256 squared value: 65536
            "010000001000000001", -- value: 257 squared value: 66049
            "010000010000000100", -- value: 258 squared value: 66564
            "010000011000001001", -- value: 259 squared value: 67081
            "010000100000010000", -- value: 260 squared value: 67600
            "010000101000011001", -- value: 261 squared value: 68121
            "010000110000100100", -- value: 262 squared value: 68644
            "010000111000110001", -- value: 263 squared value: 69169
            "010001000001000000", -- value: 264 squared value: 69696
            "010001001001010001", -- value: 265 squared value: 70225
            "010001010001100100", -- value: 266 squared value: 70756
            "010001011001111001", -- value: 267 squared value: 71289
            "010001100010010000", -- value: 268 squared value: 71824
            "010001101010101001", -- value: 269 squared value: 72361
            "010001110011000100", -- value: 270 squared value: 72900
            "010001111011100001", -- value: 271 squared value: 73441
            "010010000100000000", -- value: 272 squared value: 73984
            "010010001100100001", -- value: 273 squared value: 74529
            "010010010101000100", -- value: 274 squared value: 75076
            "010010011101101001", -- value: 275 squared value: 75625
            "010010100110010000", -- value: 276 squared value: 76176
            "010010101110111001", -- value: 277 squared value: 76729
            "010010110111100100", -- value: 278 squared value: 77284
            "010011000000010001", -- value: 279 squared value: 77841
            "010011001001000000", -- value: 280 squared value: 78400
            "010011010001110001", -- value: 281 squared value: 78961
            "010011011010100100", -- value: 282 squared value: 79524
            "010011100011011001", -- value: 283 squared value: 80089
            "010011101100010000", -- value: 284 squared value: 80656
            "010011110101001001", -- value: 285 squared value: 81225
            "010011111110000100", -- value: 286 squared value: 81796
            "010100000111000001", -- value: 287 squared value: 82369
            "010100010000000000", -- value: 288 squared value: 82944
            "010100011001000001", -- value: 289 squared value: 83521
            "010100100010000100", -- value: 290 squared value: 84100
            "010100101011001001", -- value: 291 squared value: 84681
            "010100110100010000", -- value: 292 squared value: 85264
            "010100111101011001", -- value: 293 squared value: 85849
            "010101000110100100", -- value: 294 squared value: 86436
            "010101001111110001", -- value: 295 squared value: 87025
            "010101011001000000", -- value: 296 squared value: 87616
            "010101100010010001", -- value: 297 squared value: 88209
            "010101101011100100", -- value: 298 squared value: 88804
            "010101110100111001", -- value: 299 squared value: 89401
            "010101111110010000", -- value: 300 squared value: 90000
            "010110000111101001", -- value: 301 squared value: 90601
            "010110010001000100", -- value: 302 squared value: 91204
            "010110011010100001", -- value: 303 squared value: 91809
            "010110100100000000", -- value: 304 squared value: 92416
            "010110101101100001", -- value: 305 squared value: 93025
            "010110110111000100", -- value: 306 squared value: 93636
            "010111000000101001", -- value: 307 squared value: 94249
            "010111001010010000", -- value: 308 squared value: 94864
            "010111010011111001", -- value: 309 squared value: 95481
            "010111011101100100", -- value: 310 squared value: 96100
            "010111100111010001", -- value: 311 squared value: 96721
            "010111110001000000", -- value: 312 squared value: 97344
            "010111111010110001", -- value: 313 squared value: 97969
            "011000000100100100", -- value: 314 squared value: 98596
            "011000001110011001", -- value: 315 squared value: 99225
            "011000011000010000", -- value: 316 squared value: 99856
            "011000100010001001", -- value: 317 squared value: 100489
            "011000101100000100", -- value: 318 squared value: 101124
            "011000110110000001", -- value: 319 squared value: 101761
            "011001000000000000", -- value: 320 squared value: 102400
            "011001001010000001", -- value: 321 squared value: 103041
            "011001010100000100", -- value: 322 squared value: 103684
            "011001011110001001", -- value: 323 squared value: 104329
            "011001101000010000", -- value: 324 squared value: 104976
            "011001110010011001", -- value: 325 squared value: 105625
            "011001111100100100", -- value: 326 squared value: 106276
            "011010000110110001", -- value: 327 squared value: 106929
            "011010010001000000", -- value: 328 squared value: 107584
            "011010011011010001", -- value: 329 squared value: 108241
            "011010100101100100", -- value: 330 squared value: 108900
            "011010101111111001", -- value: 331 squared value: 109561
            "011010111010010000", -- value: 332 squared value: 110224
            "011011000100101001", -- value: 333 squared value: 110889
            "011011001111000100", -- value: 334 squared value: 111556
            "011011011001100001", -- value: 335 squared value: 112225
            "011011100100000000", -- value: 336 squared value: 112896
            "011011101110100001", -- value: 337 squared value: 113569
            "011011111001000100", -- value: 338 squared value: 114244
            "011100000011101001", -- value: 339 squared value: 114921
            "011100001110010000", -- value: 340 squared value: 115600
            "011100011000111001", -- value: 341 squared value: 116281
            "011100100011100100", -- value: 342 squared value: 116964
            "011100101110010001", -- value: 343 squared value: 117649
            "011100111001000000", -- value: 344 squared value: 118336
            "011101000011110001", -- value: 345 squared value: 119025
            "011101001110100100", -- value: 346 squared value: 119716
            "011101011001011001", -- value: 347 squared value: 120409
            "011101100100010000", -- value: 348 squared value: 121104
            "011101101111001001", -- value: 349 squared value: 121801
            "011101111010000100", -- value: 350 squared value: 122500
            "011110000101000001", -- value: 351 squared value: 123201
            "011110010000000000", -- value: 352 squared value: 123904
            "011110011011000001", -- value: 353 squared value: 124609
            "011110100110000100", -- value: 354 squared value: 125316
            "011110110001001001", -- value: 355 squared value: 126025
            "011110111100010000", -- value: 356 squared value: 126736
            "011111000111011001", -- value: 357 squared value: 127449
            "011111010010100100", -- value: 358 squared value: 128164
            "011111011101110001", -- value: 359 squared value: 128881
            "011111101001000000", -- value: 360 squared value: 129600
            "011111110100010001", -- value: 361 squared value: 130321
            "011111111111100100", -- value: 362 squared value: 131044
            "100000001010111001", -- value: 363 squared value: 131769
            "100000010110010000", -- value: 364 squared value: 132496
            "100000100001101001", -- value: 365 squared value: 133225
            "100000101101000100", -- value: 366 squared value: 133956
            "100000111000100001", -- value: 367 squared value: 134689
            "100001000100000000", -- value: 368 squared value: 135424
            "100001001111100001", -- value: 369 squared value: 136161
            "100001011011000100", -- value: 370 squared value: 136900
            "100001100110101001", -- value: 371 squared value: 137641
            "100001110010010000", -- value: 372 squared value: 138384
            "100001111101111001", -- value: 373 squared value: 139129
            "100010001001100100", -- value: 374 squared value: 139876
            "100010010101010001", -- value: 375 squared value: 140625
            "100010100001000000", -- value: 376 squared value: 141376
            "100010101100110001", -- value: 377 squared value: 142129
            "100010111000100100", -- value: 378 squared value: 142884
            "100011000100011001", -- value: 379 squared value: 143641
            "100011010000010000", -- value: 380 squared value: 144400
            "100011011100001001", -- value: 381 squared value: 145161
            "100011101000000100", -- value: 382 squared value: 145924
            "100011110100000001", -- value: 383 squared value: 146689
            "100100000000000000", -- value: 384 squared value: 147456
            "100100001100000001", -- value: 385 squared value: 148225
            "100100011000000100", -- value: 386 squared value: 148996
            "100100100100001001", -- value: 387 squared value: 149769
            "100100110000010000", -- value: 388 squared value: 150544
            "100100111100011001", -- value: 389 squared value: 151321
            "100101001000100100", -- value: 390 squared value: 152100
            "100101010100110001", -- value: 391 squared value: 152881
            "100101100001000000", -- value: 392 squared value: 153664
            "100101101101010001", -- value: 393 squared value: 154449
            "100101111001100100", -- value: 394 squared value: 155236
            "100110000101111001", -- value: 395 squared value: 156025
            "100110010010010000", -- value: 396 squared value: 156816
            "100110011110101001", -- value: 397 squared value: 157609
            "100110101011000100", -- value: 398 squared value: 158404
            "100110110111100001", -- value: 399 squared value: 159201
            "100111000100000000", -- value: 400 squared value: 160000
            "100111010000100001", -- value: 401 squared value: 160801
            "100111011101000100", -- value: 402 squared value: 161604
            "100111101001101001", -- value: 403 squared value: 162409
            "100111110110010000", -- value: 404 squared value: 163216
            "101000000010111001", -- value: 405 squared value: 164025
            "101000001111100100", -- value: 406 squared value: 164836
            "101000011100010001", -- value: 407 squared value: 165649
            "101000101001000000", -- value: 408 squared value: 166464
            "101000110101110001", -- value: 409 squared value: 167281
            "101001000010100100", -- value: 410 squared value: 168100
            "101001001111011001", -- value: 411 squared value: 168921
            "101001011100010000", -- value: 412 squared value: 169744
            "101001101001001001", -- value: 413 squared value: 170569
            "101001110110000100", -- value: 414 squared value: 171396
            "101010000011000001", -- value: 415 squared value: 172225
            "101010010000000000", -- value: 416 squared value: 173056
            "101010011101000001", -- value: 417 squared value: 173889
            "101010101010000100", -- value: 418 squared value: 174724
            "101010110111001001", -- value: 419 squared value: 175561
            "101011000100010000", -- value: 420 squared value: 176400
            "101011010001011001", -- value: 421 squared value: 177241
            "101011011110100100", -- value: 422 squared value: 178084
            "101011101011110001", -- value: 423 squared value: 178929
            "101011111001000000", -- value: 424 squared value: 179776
            "101100000110010001", -- value: 425 squared value: 180625
            "101100010011100100", -- value: 426 squared value: 181476
            "101100100000111001", -- value: 427 squared value: 182329
            "101100101110010000", -- value: 428 squared value: 183184
            "101100111011101001", -- value: 429 squared value: 184041
            "101101001001000100", -- value: 430 squared value: 184900
            "101101010110100001", -- value: 431 squared value: 185761
            "101101100100000000", -- value: 432 squared value: 186624
            "101101110001100001", -- value: 433 squared value: 187489
            "101101111111000100", -- value: 434 squared value: 188356
            "101110001100101001", -- value: 435 squared value: 189225
            "101110011010010000", -- value: 436 squared value: 190096
            "101110100111111001", -- value: 437 squared value: 190969
            "101110110101100100", -- value: 438 squared value: 191844
            "101111000011010001", -- value: 439 squared value: 192721
            "101111010001000000", -- value: 440 squared value: 193600
            "101111011110110001", -- value: 441 squared value: 194481
            "101111101100100100", -- value: 442 squared value: 195364
            "101111111010011001", -- value: 443 squared value: 196249
            "110000001000010000", -- value: 444 squared value: 197136
            "110000010110001001", -- value: 445 squared value: 198025
            "110000100100000100", -- value: 446 squared value: 198916
            "110000110010000001", -- value: 447 squared value: 199809
            "110001000000000000", -- value: 448 squared value: 200704
            "110001001110000001", -- value: 449 squared value: 201601
            "110001011100000100", -- value: 450 squared value: 202500
            "110001101010001001", -- value: 451 squared value: 203401
            "110001111000010000", -- value: 452 squared value: 204304
            "110010000110011001", -- value: 453 squared value: 205209
            "110010010100100100", -- value: 454 squared value: 206116
            "110010100010110001", -- value: 455 squared value: 207025
            "110010110001000000", -- value: 456 squared value: 207936
            "110010111111010001", -- value: 457 squared value: 208849
            "110011001101100100", -- value: 458 squared value: 209764
            "110011011011111001", -- value: 459 squared value: 210681
            "110011101010010000", -- value: 460 squared value: 211600
            "110011111000101001", -- value: 461 squared value: 212521
            "110100000111000100", -- value: 462 squared value: 213444
            "110100010101100001", -- value: 463 squared value: 214369
            "110100100100000000", -- value: 464 squared value: 215296
            "110100110010100001", -- value: 465 squared value: 216225
            "110101000001000100", -- value: 466 squared value: 217156
            "110101001111101001", -- value: 467 squared value: 218089
            "110101011110010000", -- value: 468 squared value: 219024
            "110101101100111001", -- value: 469 squared value: 219961
            "110101111011100100", -- value: 470 squared value: 220900
            "110110001010010001", -- value: 471 squared value: 221841
            "110110011001000000", -- value: 472 squared value: 222784
            "110110100111110001", -- value: 473 squared value: 223729
            "110110110110100100", -- value: 474 squared value: 224676
            "110111000101011001", -- value: 475 squared value: 225625
            "110111010100010000", -- value: 476 squared value: 226576
            "110111100011001001", -- value: 477 squared value: 227529
            "110111110010000100", -- value: 478 squared value: 228484
            "111000000001000001", -- value: 479 squared value: 229441
            "111000010000000000", -- value: 480 squared value: 230400
            "111000011111000001", -- value: 481 squared value: 231361
            "111000101110000100", -- value: 482 squared value: 232324
            "111000111101001001", -- value: 483 squared value: 233289
            "111001001100010000", -- value: 484 squared value: 234256
            "111001011011011001", -- value: 485 squared value: 235225
            "111001101010100100", -- value: 486 squared value: 236196
            "111001111001110001", -- value: 487 squared value: 237169
            "111010001001000000", -- value: 488 squared value: 238144
            "111010011000010001", -- value: 489 squared value: 239121
            "111010100111100100", -- value: 490 squared value: 240100
            "111010110110111001", -- value: 491 squared value: 241081
            "111011000110010000", -- value: 492 squared value: 242064
            "111011010101101001", -- value: 493 squared value: 243049
            "111011100101000100", -- value: 494 squared value: 244036
            "111011110100100001", -- value: 495 squared value: 245025
            "111100000100000000", -- value: 496 squared value: 246016
            "111100010011100001", -- value: 497 squared value: 247009
            "111100100011000100", -- value: 498 squared value: 248004
            "111100110010101001", -- value: 499 squared value: 249001
            "111101000010010000", -- value: 500 squared value: 250000
            "111101010001111001", -- value: 501 squared value: 251001
            "111101100001100100", -- value: 502 squared value: 252004
            "111101110001010001", -- value: 503 squared value: 253009
            "111110000001000000", -- value: 504 squared value: 254016
            "111110010000110001", -- value: 505 squared value: 255025
            "111110100000100100", -- value: 506 squared value: 256036
            "111110110000011001", -- value: 507 squared value: 257049
            "111111000000010000", -- value: 508 squared value: 258064
            "111111010000001001", -- value: 509 squared value: 259081
            "111111100000000100", -- value: 510 squared value: 260100
            "111111110000000001" -- value: 511 squared value: 261121
);

begin

process(clk)

begin

if rising_edge (clk) then

data_out <= RAM(to_integer(addr));

end if;

end process;

end syn;