import std.stdio, std.string, std.array, std.conv, std.algorithm;

char[10^^5] SS;

char conv(char who, char what, char whom)
{
    switch (who) {
        case 'S':
            switch (what) {
                case 'o':
                    switch (whom) {
                        case 'S':
                            return 'S';
                        case 'W':
                            return 'W';
                        default:
                    }
                    break;
                case 'x':
                    switch (whom) {
                        case 'S':
                            return 'W';
                        case 'W':
                            return 'S';
                        default:
                    }
                    break;
                default:
            }
            break;
        case 'W':
            switch (what) {
                case 'o':
                    switch (whom) {
                        case 'S':
                            return 'W';
                        case 'W':
                            return 'S';
                        default:
                    }
                    break;
                case 'x':
                    switch (whom) {
                        case 'S':
                            return 'S';
                        case 'W':
                            return 'W';
                        default:
                    }
                    break;
                default:
            }
            break;
        default:
    }
    throw new Exception("Invalid charactor. [" ~ who ~ ", " ~ what ~ ", " ~ whom ~ "]");
}

char[] solve(long n, char[] zoo)
{
    zoo.length = n+1;
    for (size_t i = 2; i <= n; ++i)
        zoo[i] = conv(zoo[i-1], SS[i-1], zoo[i-2]);
    if (zoo[0] == zoo[n] && zoo[n-1] == conv(zoo[0], SS[0], zoo[1]))
        return zoo[0..n];
    return null;
}

void main()
{
    auto n = readln.chomp.to!long;
    foreach (i, s; readln.chomp) SS[i] = s;
    
    auto ret = solve(n, ['S', 'S']);
    if (!ret) ret = solve(n, ['S', 'W']);
    if (!ret) ret = solve(n, ['W', 'S']);
    if (!ret) ret = solve(n, ['W', 'W']);
    
    if (ret)
        writeln(ret);
    else
        writeln("-1");
}