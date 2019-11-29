import std.stdio, std.algorithm, std.conv, std.array, std.string;

long P = 10^^9+7;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto n = nm[0] > nm[1] ? nm[0] : nm[1];
    auto m = n == nm[0] ? nm[1] : nm[0];

    if (n == m || n == m+1) {
        long x = 1;
        foreach (i; 2..n+1) x = (x*i)%P;
        foreach (i; 2..m+1) x = (x*i)%P;
        if (n == m) x = (x*2)%P;
        writeln(x);
    } else {
        writeln(0);
    }
}