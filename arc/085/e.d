import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

long[100][100] Graph;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    foreach (i, a; AS) {
        foreach (j, ref b; Graph[i]) if ((j+1) % (i+1) == 0) b = a;
    }

    foreach (_; 0..100) {
        foreach (i, line; Graph) {
            long sum;
            foreach (ll; Graph) sum += ll[i];
            if (sum < 0) {
                Graph[i] = 0;
            }
        }
    }

    writeln(Graph[0..6].map!(l => l[0..6].array).array);

    long sum;
    foreach (i, ll; Graph) sum += ll[i];
    writeln(sum);
}