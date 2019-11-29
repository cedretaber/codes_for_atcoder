import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

auto mk_ret() {
    wchar[100][100] ret;
    foreach (i; 0..50) ret[i] = '#';
    foreach (i; 50..100) ret[i] = '.';
    return ret;
}
auto ret = mk_ret();

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0] - 1;
    auto B = ab[1] - 1;

    for (int i; A; i += 2) {
        for (int j; A && j < 100; j += 2) {
            --A;
            ret[i][j] = '.';
        }
    }
    for (int i = 51; B; i += 2) {
        for (int j; B && j < 100; j += 2) {
            --B;
            ret[i][j] = '#';
        }
    }
    
    writeln("100 100");
    foreach (line; ret) writeln(line);
}