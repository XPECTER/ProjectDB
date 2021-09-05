using System;

namespace WELLalgorithm
{
    public class WELL512
    {
        static uint[] state = new uint[16];
        static uint index = 0;

        // seed값 설정
        static WELL512()
        {
            Random random = new Random((int)DateTime.Now.Ticks);

            for (int i = 0; i < 16; i++)
            {
                state[i] = (uint)random.Next();
            }
        }

        // 최소값, 최대값 받아서 사이값만 나오게
        public static uint Next(int minValue, int maxValue)
        {
            return (uint)((Next() % (maxValue - minValue)) + minValue);
        }

        // 0부터 maxValue까지 랜덤
        public static uint Next(uint maxValue)
        {
            return Next() % maxValue;
        }

        // 시드값에 의한 의사 난수 생성
        public static uint Next()
        {
            uint a, b, c, d;

            a = state[index];
            c = state[(index + 13) & 15];
            b = a ^ c ^ (a << 16) ^ (c << 15);
            c = state[(index + 9) & 15];
            c ^= (c >> 11);
            a = state[index] = b ^ c;
            d = a ^ ((a << 5) & 0xda442d24U);
            index = (index + 15) & 15;
            a = state[index];
            state[index] = a ^ b ^ d ^ (a << 2) ^ (b << 18) ^ (c << 28);

            return state[index];
        }
    }
}