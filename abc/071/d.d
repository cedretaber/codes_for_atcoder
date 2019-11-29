import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[][52] SS;
dchar[52] CS;

long N = 1000000007;

void main()
{
    auto n = readln.chomp.to!int;
    auto s1 = readln.chomp.to!(dchar[]);
    auto s2 = readln.chomp.to!(dchar[]);

    auto j = 0;
    for (auto i = 0; i < n; ++i) {
        if (s1[i] == s2[i]) {
            if (i == 0) {
                SS[j] = [];
            } else if (s1[i-1] == s2[i-1]) {
                SS[j] = [j-1];
            } else {
                SS[j] = [j-2, j-1];
            }
        } else {
            if (i == 0) {
                SS[j++] = [];
                SS[j] = [j-1];
            } else if (s1[i-1] == s2[i-1]) {
                SS[j] = [j-1];
                ++j;
                SS[j] = [j-2, j-1];
            } else {
                SS[j] = [j-2];
                ++j;
                SS[j] = [j-2, j-1];
            }
            ++i;
        }
        ++j;
    }

    long[immutable(dchar)[]][52] memo;

    long solve(int i) {
        if (i == n) return 1;

        immutable(dchar)[] key;
        foreach (j; (i-2 < 0 ? 0 : i-2)..i) key ~= CS[j];
        if (key in memo[i]) return memo[i][key];

        auto cls = 0b111;
        foreach (j; SS[i]) {
            switch (CS[j]) {
                case 'R':
                    cls &= 0b011;
                    break;
                case 'G':
                    cls &= 0b101;
                    break;
                case 'B':
                    cls &= 0b110;
                    break;
                default:
            }
        }

        long ret;
        if (cls & 0b100) {
            CS[i] = 'R';
            ret = (ret + solve(i+1)) % N;
        }
        if (cls & 0b010) {
            CS[i] = 'G';
            ret = (ret + solve(i+1)) % N;
        }
        if (cls & 0b001) {
            CS[i] = 'B';
            ret = (ret + solve(i+1)) % N;
        }
        return memo[i][key] = ret;
    }

    writeln(solve(0));
}