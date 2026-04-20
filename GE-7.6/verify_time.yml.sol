---
- name: Verify Time Synchronization
  hosts: webservers

  tasks:
    - name: Display chrony configuration
      ansible.builtin.shell: grep -E "^pool|^server" /etc/chrony.conf || echo "No pool/server found"
      register: chrony_config
      changed_when: false

    - name: Display chrony configuration
      ansible.builtin.debug:
        msg: "{{ chrony_config.stdout_lines }}"
