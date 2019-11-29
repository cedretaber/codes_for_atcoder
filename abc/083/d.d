import std.stdio, std.algorithm, std.conv, std.array, std.string;

bool check(int k, bool[] s)
{
    auto t = s[0];
    int last;
    foreach (i, e; s) if (t != e) {
        t = e;
        last = i.to!int;
    }
    return last < s.length - k;
}

void main()
{
    auto S = readln.chomp.to!(dchar[]).map!(c => c == '1').array;
    int min_n = 1, middle, max_n = S.length.to!int;

    do {
        middle = (min_n + max_n) / 2;
        if (check(middle, S))
            min_n = middle;
        else
            max_n = middle;
    } while (min_n != max_n && min_n+1 != max_n);

    writeln(check(max_n, S) ? max_n : min_n);
}

/*

111000111000111
111111000111111
000000111111111
000000000000000

111111111000000


11000000110101101001
11111111001011101001
11111111110100010111
00000000000100010111
11111111111000010111
00000000000000010111
11111111111111110111
00000000000000000111
11111111111111111111
00000000000000000000

11111111100000000000


001111000011



100010001

111101111
000010000

*/