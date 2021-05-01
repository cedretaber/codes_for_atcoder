import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

void main()
{
    int R, C; get(R, C);
    char[][] OO; get_lines(R, OO);

    auto memo = new bool[][][][](R, C, 4, 16);
    bool solve(int r, int c, int d, int m) {
        if (OO[r][c] == '@') return true;
        if (memo[r][c][d][m]) return false;
        memo[r][c][d][m] = true;

        switch (OO[r][c]) {
            case '<': d = 2; break;
            case '>': d = 0; break;
            case '^': d = 1; break;
            case 'v': d = 3; break;
            case '_': d = m == 0 ? 0 : 2; break;
            case '|': d = m == 0 ? 3 : 1; break;
            case '?':
                if (solve(r, (c + 1) % C, 0, m)) return true;
                if (solve((r + R - 1) % R, c, 1, m)) return true;
                if (solve(r, (c + C - 1) % C, 2, m)) return true;
                if (solve((r + 1) % R, c, 3, m)) return true;
                return false;
            case '0': .. case '9': m = OO[r][c] - '0'; break;
            case '+': (m += 1) %= 16; break;
            case '-': (m += 15) %= 16; break;
            default:
        }
        switch (d) {
            case 0: return solve(r, (c + 1) % C, 0, m);
            case 1: return solve((r + R - 1) % R, c, 1, m);
            case 2: return solve(r, (c + C - 1) % C, 2, m);
            case 3: return solve((r + 1) % R, c, 3, m);
            default:
        }
        return false;
    }
    writeln(solve(0, 0, 0, 0) ? "YES" : "NO");
}
