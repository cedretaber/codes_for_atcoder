import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto N = S.length;
    long r;
    foreach (i, c; S) {
        if (c == 'U') {
            r += i*2 + N-i-1;
        } else {
            r += (N-i-1)*2 + i;
        }
    }
    writeln(r);
}