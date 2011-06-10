a = linspace(0,1,10);
b = [1];
a = (linspace(0,10,100));

for i=1:length(a)
  for j=1:length(b)
    plot(generate_arbitrary_fm(1,100,1, b(j),a(i)))
    s = sprintf('%i:%i',i,j);
    title(s);
    pause(.1)
  end
end

