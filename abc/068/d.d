import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

long K;
long[50] R;

void main()
{
    K = readln.chomp.to!long;

    if (K == 0) {
        writeln("2\n0 0");
    } else if (K == 1) {
        writeln("2\n2 0");
    } else if (K <= 50) {
        writeln(K);
        writeln( 1.iota(K+1).map!(to!string).joiner(" ") );
    } else {
        foreach (i; 0..50) R[i] = 50 - i;
        auto t = K / 50 - 1;
        foreach (ref r; R) r += t;
        foreach (i; 0..K%50) R[i] += 1;

        writeln(50);
        writeln(R.dup.map!(to!string).joiner(" ")); 
    }
}