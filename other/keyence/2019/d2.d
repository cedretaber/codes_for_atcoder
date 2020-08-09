import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto ab = new bool[][](2, N*M);
    foreach (a; readln.split.to!(int[])) {
        if (ab[0][a-1]) {
            writeln(0);
            return;
        }
        ab[0][a-1] = true;
    }
    foreach (b; readln.split.to!(int[])) {
        if (ab[1][b-1]) {
            writeln(0);
            return;
        }
        ab[1][b-1] = true;
    }

    long n, m, b, r = 1;
    foreach_reverse (i; 0..N*M) {
        if (ab[0][i] && ab[1][i]) {
            n += 1;
            m += 1;
        } else if (ab[0][i]) {
            n += 1;
            (r *= m) %= P;
        } else if (ab[1][i]) {
            m += 1;
            (r *= n) %= P;
        } else {
            (r *= (m*n-b)) %= P;
        }
        b += 1;
    }
    writeln(r);
}

/*

2 2
4 3
3 4

  3 4
4   4
3 3

2 * 1

4 3 2 2

3 3
5 9 7
3 6 9

  3 6 9
5
9     9
7


14 13
158 167 181 147 178 151 179 182 176 169 180 129 175 168
181 150 178 179 167 180 176 169 182 177 175 159 173

    181 150 178 179 167 180 176 169 182 177 175 159 173
158
167                 167
181 181                                 177
147
178         178                         177
151
179             179                     177
182                                 182 177
176 174     174 174     174 176     174 174
169                             169
180                     180 174     174 177
129
175                                         175
168

*/