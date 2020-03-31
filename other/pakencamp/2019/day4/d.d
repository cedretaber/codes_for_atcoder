import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];

    auto as = new int[](N);
    as[] = 10^^9;

    size_t i;
    while (X) {
        int x = 1;
        for (; x*(x+1)/2 <= X;) ++x;
        --x;
        writeln(x);
        foreach (j; 0..x) as[i+j] = 1;
        X -= x*(x+1)/2;
        i += x+1;
    }
    writeln(1000);
    writeln(as.to!(string[]).join(" "));
}