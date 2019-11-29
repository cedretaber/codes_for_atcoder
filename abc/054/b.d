import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration;

void main()
{
    immutable nm = readln.chomp.split(" ").map!(to!int).array;
    immutable n = nm[0];
    immutable m = nm[1];

    string[] a;
    a.length = n;
    foreach(i; 0..n)
        a[i] = readln.chomp;

    string[] b;
    b.length = m;
    foreach(i; 0..m)
        b[i] = readln.chomp;
    
    while (a[0].length >= m) {
        
        auto aa = a[].map!(l => l[0..m]).array;
        while(aa.length >= m) {
            if (aa[0..m] == b) {
                writeln("Yes");
                return;
            }
            aa = aa[1..$];
        }

        foreach(i, l; a)
            a[i] = l[1..$];
    }

    writeln("No");
}