import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto T = readln.chomp.split(" ")[1].to!long;
    auto ts = readln.chomp.split(" ").map!(to!int);

    long sum;
    int last = 0;
    foreach (t; ts[1..$]) {
        if (t - last < T)
            sum += (t - last);
        else
            sum += T;
        last = t;
    }

    writeln(sum + T);
}