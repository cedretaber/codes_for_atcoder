import std.stdio, std.string, std.array, std.algorithm, std.conv;

void main()
{
    immutable nm = readln.chomp.split(" ").map!(to!int).array;
    immutable n = nm[0];
    immutable m = nm[1];

    auto nodes = new int[][n];

    foreach(_i; 0..m) {
        auto ab = readln.chomp.split(" ").map!(to!int).array;
        nodes[ab[0]-1] ~= ab[1]-1;
        nodes[ab[1]-1] ~= ab[0]-1;
    }

    int search(int pos, int[] hist)
    {
        auto nexts = nodes[pos].filter!(n => hist.find(n).empty);

        if (nexts.empty) {
            if (hist.length == n)
                return 1;
            else
                return 0;
        }

        return reduce!"a + b"(0, nexts.map!(node => search(node, hist ~ node)));
    }

    writeln(search(0, [0]));
}