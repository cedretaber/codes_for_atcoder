import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

long[10^^5][4] CS;

int P = 10^^9+7;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    auto len = S.length;
    foreach_reverse(i, c; S) {
        if (i == len-1) {
            switch (c) {
                case 'C':
                    CS[2][len-1] = 1;
                    CS[3][len-1] = 1;
                    break;
                case '?':
                    CS[2][len-1] = 1;
                    CS[3][len-1] = 3;
                    break;
                default:
                    CS[3][len-1] = 1;
            }
        } else {
            foreach (j; 0..4) {
                CS[j][i] = CS[j][i+1];
            }
            switch (c) {
                case 'A':
                    CS[0][i] = (CS[0][i+1] + CS[1][i+1]) % P;
                    break;
                case 'B':
                    CS[1][i] = (CS[1][i+1] + CS[2][i+1]) % P;
                    break;
                case 'C':
                    CS[2][i] = (CS[2][i+1] + CS[3][i+1]) % P;
                    break;
                default:
                    CS[0][i] = (CS[0][i+1] * 3 + CS[1][i+1]) % P;
                    CS[1][i] = (CS[1][i+1] * 3 + CS[2][i+1]) % P;
                    CS[2][i] = (CS[2][i+1] * 3 + CS[3][i+1]) % P;
                    CS[3][i] = (CS[3][i] * 3) % P;
            }
        }
    }
    writeln(CS[0][0]);
}