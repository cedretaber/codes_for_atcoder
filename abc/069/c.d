import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    int even_cnt;
    int quart_cnt;

    foreach (a; as) {
        if (!(a&1)) {
            ++even_cnt;
            if (!(a&2))
                ++quart_cnt;
        }
    }

    if (quart_cnt >= (n - even_cnt) || (even_cnt == quart_cnt && (n - quart_cnt * 2) == 1))
        writeln("Yes");
    else
        writeln("No");
}