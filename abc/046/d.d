import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[int][10^^5 + 1] MEMO;

void main()
{
    auto s = readln.chomp;
    auto n = s.length;

    int resolve(int i, int p) {
        if (p in MEMO[i]) return MEMO[i][p];

        int ret;
        if (i == n) {
            ret = 0;
        } else {
            switch (s[i]) {
                case 'g':
                    ret = p == 0 ?
                        resolve(i+1, p+1)
                    :
                        max(resolve(i+1, p-1) + 1, resolve(i+1, p+1));
                    break;
                case 'p':
                    ret = p == 0 ?
                        resolve(i+1, p+1) - 1
                    :
                        max(resolve(i+1, p-1), resolve(i+1, p+1) - 1);
                    break;
                default:
            }
        }

        return MEMO[i][p] = ret;
    }

    writeln(resolve(0, 0));
}