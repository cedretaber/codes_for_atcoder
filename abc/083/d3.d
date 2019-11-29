import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto S = readln.chomp.to!(dchar[]);
    auto N = S.length;
    size_t i = 0, j = S.length - 1;
    auto a = S[0], b = S[0], c = S[$-1], d = S[$-1];

    int x, y;
    foreach (s; S) {
        ++(s == '1' ? x : y);
    }
    if (!x || !y) {
        writeln(N);
        return;
    }

    while (i <= j) {
        if (i + 1 < N - j) {
            a = S[i];
            while (a == b) b = S[++i];
        } else {
            d = S[j];
            while (c == d) c = S[--j];
        }
    }
    writeln(i > N - j - 1 ? i : N - j - 1);
}