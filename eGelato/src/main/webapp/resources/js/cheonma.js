class CustomCheckboxRenderer {
    constructor(props) {
        const { grid, rowKey,columnInfo, value } = props;
        const label = document.createElement('checkbox');
/*         const { disabled } = props.columnInfo.renderer.options; */
        label.className = 'checkbox';
        //label.setAttribute('for', String(rowKey));

        const hiddenInput = document.createElement('input');
        hiddenInput.className = 'hidden-input';
        hiddenInput.id = String(rowKey);

        hiddenInput.setAttribute( 'data-check-val', '0' );
        
        label.appendChild(hiddenInput);

        hiddenInput.type = 'checkbox';
        hiddenInput.addEventListener('change', () => {
            if (hiddenInput.checked) {
                hiddenInput.setAttribute( 'data-check-val', '1' );
                grid.setValue(rowKey, columnInfo.name, "1");
            } else {
                hiddenInput.setAttribute( 'data-check-val', '0' );
                grid.setValue(rowKey, columnInfo.name, "0");
            }
            try {
                fnCustomChkboxChange();
            } catch(e) {
                
            }
            
        });

        this.el = label;

        this.render(props);
    }

    getElement() {
        return this.el;
    }

    render(props) {
    const hiddenInput = this.el.querySelector('.hidden-input');
    const checked = Boolean(props.value == '1');
    hiddenInput.checked = checked;
   const disabled = props.columnInfo.renderer.disabled;
    hiddenInput.disabled = disabled; 
    }
};


class CustomBtnRenderer {
    constructor(props) {
        const { grid, rowKey,columnInfo, value } = props;
        const button = document.createElement('button');
        const txtNode = document.createTextNode( value );
        button.appendChild( txtNode );
        
        //button.className = 'btn-sm btn-find-on-small';
        button.className = 'btn btn-sm';
    
        this.el = button;
        //this.render(props);
    }
    getElement() {
        return this.el;
    }
};


class CustomTextEditor {
    constructor(props) {
      const el = document.createElement('input');
      const { maxLength } = props.columnInfo.editor.options;

      el.type = 'text';
      el.maxLength = maxLength;
      el.value = String(props.value);

      this.el = el;
    }

    getElement() {
      return this.el;
    }

    getValue() {
      return this.el.value;
    }

    mounted() {
      this.el.select();
    }
  };
  