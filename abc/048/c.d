import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto x = readln.split[1].to!long;
    auto as = readln.split.to!(long[]);

    auto last = as[0];
    long let = 0;
    foreach (a; as[1..$]) {
        long d;
        if (a+last > x) {
            d = (a+last) - x;
            let += d;
        }
        last = a-d < 0 ? 0 : a-d;
    }

    writeln(let);
}