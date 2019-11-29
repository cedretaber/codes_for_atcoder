import std.stdio, std.string, std.array, std.conv, std.algorithm, std.functional;

bool[8][8] PS;

void main()
{   
    auto nm = readln.split.to!(int[]);
    auto n = nm[0];
    auto m = nm[1];

    foreach (_; 0..m) {
        auto ab = readln.split.to!(int[]);
        PS[ab[0]-1][ab[1]-1] = true;
        PS[ab[1]-1][ab[0]-1] = true;
    }

    int search(int pos, int[] hists) {
        int[] nexts;
        foreach (i, c; PS[pos])
            if (c && hists.find(i).empty) nexts ~= i.to!int;

        if (nexts.empty)
            return hists.length == n ? 1 : 0;
        
        return reduce!"a + b"(0, nexts.map!(n => search(n, hists ~ n)));
    }

    writeln(search(0, [0]));
}