import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    readln;
    int[int] as;
    foreach (a; readln.split.to!(int[])) as[a] += 1;
    int r;
    foreach (a, n; as) {
        if (n >= a) {
            r += n - a;
        } else {
            r += n;
        }
    }
    writeln(r);
}